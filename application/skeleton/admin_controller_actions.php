public function {model|plural}Action(){
        $this->view->bodyclass = array("{model}");
    	$this->view->model = "{model}";
    	$this->view->primary = Jien::model($this->view->model)->getPrimary();
    	$this->view->data = Jien::model($this->view->model)->orderBy("{model|lower}.{model|col}_id DESC")->withPager($this->params('page', 1))->filter($this->params())->get();
    }

    public function {model|lcfirst}Action(){
        $this->view->bodyclass = array("{model}");
    	$this->view->model = "{model}";
    	$id = $this->params('id');
    	if($id){
    		$this->view->data = Jien::model($this->view->model)->get($id);
    	}
    	$this->view('form');
    }

    // skeleton - dont remove this line, it's for scaffolding reason //
