<?php

class AdminController extends My_Controller {

    public function init(){

        parent::init();

        // remember me if cookie exists
        if(!empty($_COOKIE['remember']) && empty($_SESSION['user'])){
            $user = Jien::model("User")->joinRole()->joinProvider()->get(Jien::decrypt($_COOKIE['remember']['user_id'],SALT))->row();
            $this->setUser($user);
        }

        if($this->hasRole("moderator")){

            // set it to remember me for 7 days
            if(empty($_COOKIE['remember'])){
                $expires =  time()+(86400 * 7);
                setcookie("remember[user_id]", Jien::encrypt($_SESSION['user']['user_id'], SALT), $expires);
                setcookie("remember[expires]", $expires, $expires);
            }
            $this->layout('admin');

        }else{
            $this->layout('admin-loggedout');
            $this->view('index');
        }

        // view vars
        $this->title("ProcCRM");
        $this->view->data = new Jien_Model_Factory(); // model output, contains row()/rows()/pager()
    }

    // all the save/delete requests goes through here and calls on the model's save/delete accordingly
    public function dataAction(){
        $data = $this->params();

        $model = $data['model'];
        $cmd = $this->params('cmd', 'save');

        try {
            switch($cmd){
                case "save":
                $id = Jien::model($model)->save($data);
                $primary = Jien::model($model)->getPrimary();

                //updated to save authenticator.
                if($model == 'User'){
                    if($data['authenticator']){
                        $authenticator_check = Jien::model('Authenticator')->Where('authenticator_user_id = ' . $data['id'])->get()->row();
                        if(empty($authenticator_check)){
                            $auth_data = array(
                                "authenticator_user_id" => $data['id'],
                                "authenticator_secret" => $data['auth_secret'],
                                "authenticator_sms" => $data['auth_sms']
                            );
                            Jien::model('Authenticator')->save($auth_data);
                        }else{
                            $auth_data = array(
                                "authenticator_user_id" => $data['id'],
                                "authenticator_sms" => $data['auth_sms']
                            );
                            Jien::model('Authenticator')->save($auth_data);
                        }
                    }else{
                        $authenticator_check = Jien::model('Authenticator')->Where('authenticator_user_id = ' . $data['id'])->get()->row();
                        if(!empty($authenticator_check)){
                            Jien::model('Authenticator')->delete($authenticator_check['authenticator_id']);
                        }
                    }
                }
                $this->json(array($primary=>$id), 200, 'saved');
                break;

                case "delete":
                $id = $this->params('id');
                $affected = Jien::model($model)->delete($id);
                $this->json(array("affected"=>$affected), 200, 'deleted');
                break;

                case "get":
                $id = $this->params('id');
                $affected = Jien::model($model)->get($id);
                $this->json($affected->row(), 200, 'returned');
                break;

            }
        }catch(Exception $e){
            $this->json(array(), 405, $e->getMessage());
        }
    }

    public function indexAction(){
        if(!empty($_SESSION['user'])){
            $this->_forward('dashboard');
        }
    }

    public function dashboardAction(){
        $this->view->title = 'Dashboard';
        $this->view->bodyclass = array('dashboard');
    }

    public function scaffoldAction(){
        $this->view->title = 'Scaffolder';
        $this->view->bodyclass = array('scaffolder');
        $model = $this->params('model');
        $scaffold = new Jien_Scaffold();
        $scaffold->generateFromTable($model);
        exit;
    }

    public function configureScaffolderAction(){
        $this->view->title = 'Scaffolder';
        $this->view->bodyclass = array('scaffolder');
    }

    public function scaffoldFormAction(){
        $data = $this->params();

        $data['tbl_name'] = strtolower($data['tbl_name']);
        $data['tbl_name'] = ucfirst($data['tbl_name']);

        $scaffold = new Jien_Scaffold();
        $res = $scaffold->createTable($data);

        if($res){
            $scaffold->generateFromTable($data['tbl_name']);
        }

        $this->json($res);

        exit;
    }

    public function usersAction(){
        $this->view->title = 'Users';
        $this->view->bodyclass = array('users');
        $this->view->model = "User";
        $this->view->primary = Jien::model($this->view->model)->getPrimary();
        $this->view->data = Jien::model($this->view->model)->orderBy("u.user_id DESC")->joinProvider()->joinRole()->withPager($this->params('page', 1))->filter($this->params())->get();
    }

    public function userAction(){
        $this->view->title = 'View/Edit User';
        $this->view->bodyclass = array('user');
        $this->view->model = "User";
        $this->view->roles = Jien::model('Role')->get();
        $id = $this->params('id');
        if($id){
            $this->view->data = Jien::model($this->view->model)->get($id);
        }
        $this->view->authenticator = Jien::Model('Authenticator')->Where('authenticator_user_id = ' . $id)->get();
    }

    public function rolesAction(){
        $this->view->title = 'Roles';
        $this->view->bodyclass = array('roles');
        $this->view->model = "Role";
        $this->view->primary = Jien::model($this->view->model)->getPrimary();
        $this->view->data = Jien::model($this->view->model)->orderBy("role.role_id ASC")->withPager($this->params('page', 1))->filter($this->params())->get();
    }

    public function roleAction(){
        if($this->params('id')) {
            $this->view->title = 'Update Role';
        } else {
            $this->view->title = 'Add Role';
        }
        $this->view->bodyclass = array('role');
        $this->view->model = "Role";
        $id = $this->params('id');
        if($id){
            $this->view->data = Jien::model($this->view->model)->get($id);
        }
    }

    public function postsAction(){
        $this->view->title = 'Posts';
        $this->view->bodyclass = array('posts');
        $this->view->model = "Post";
        $this->view->primary = Jien::model($this->view->model)->getPrimary();
        $this->view->data = Jien::model($this->view->model)->orderBy("p.post_id DESC")->joinCategory()->joinUser()->withPager($this->params('page', 1))->filter($this->params())->get();
    }

    public function postAction(){
        if($this->params('id')) {
            $this->view->title = 'Update Post';
        } else {
            $this->view->title = 'Add Post';
        }
        $this->view->bodyclass = array('post');
        $this->view->model = "Post";
        $id = $this->params('id');
        if($id){
            $this->view->data = Jien::model($this->view->model)->joinUser('u.username')->get($id);
        }
    }

    public function pagesAction(){
        $this->view->model = "Page";
        $this->view->primary = Jien::model($this->view->model)->getPrimary();
        $this->view->data = Jien::model($this->view->model)->orderBy("page.rank ASC")->withPager($this->params('page', 1))->filter($this->params())->get();
    }

    public function pageAction(){
        $this->view->model = "Page";
        $id = $this->params('id');
        if($id){
            $this->view->data = Jien::model($this->view->model)->get($id);
        }
    }

     public function categoriesAction(){
        $this->view->title = 'Categories';
        $this->view->bodyclass = array('categories');
        $this->view->model = "Category";
        $this->view->primary = Jien::model($this->view->model)->getPrimary();
        $this->view->data = Jien::model($this->view->model)
        ->orderBy("category.category_id DESC")
        ->filter($this->params())
        ->withPager($this->params('page', 1))
        ->get();
    }

    public function categoryAction(){
        if($this->params('id')) {
            $this->view->title = 'Update Category';
        } else {
            $this->view->title = 'Add Category';
        }
        $this->view->bodyclass = array('category');
        $this->view->model = "Category";
        $id = $this->params('id');
        if($id){
            $this->view->data = Jien::model($this->view->model)->get($id);
        }
    }

    public function hitsAction(){
        $this->view->model = "Hit";
        $this->view->primary = Jien::model($this->view->model)->getPrimary();
        $this->view->data = Jien::model($this->view->model)->orderBy("hit.hit_id DESC")->withPager($this->params('page', 1))->filter($this->params())->get();
    }

    public function hitAction(){
        $this->view->model = "Hit";
        $id = $this->params('id');
        if($id){
            $this->view->data = Jien::model($this->view->model)->get($id);
        }
        $this->view('form');
    }

    // skeleton - dont remove this line, it's for scaffolding reason //

}
