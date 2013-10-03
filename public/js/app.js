var scaffolder = angular.module('scaffolder', []);

function TableCtrl($scope){

    $scope.showTblName = function(a,b,c){
        console.log(this);
    }
}