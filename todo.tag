<todo>

  <div class="ui three column center aligned padded grid">

    <div class="row">
      <div class="one field eight wide column">
        <h1 class="ui teal header">
          <div class="content">TASK MANAGER</div>
        </h1>

        <form class="ui huge form" onsubmit={ addTask }>
          <div class="field">
            <input type="text" name="first-name" placeholder="Enter task">
          </div>
        </form>
      </div>

    </div>

    <div class="row">
      <div class="one field eight wide column">
        <div class="ui tabular secondary pointing menu large">
          <div class="right menu">
            <a class="active item red" onclick={ showPendingTasks }>todo</a>
            <a class="item green" onclick={ showFinishedTasks }>done</a>
            <a class="item orange" onclick={ showAllTasks } >all</a>
          </div>
        </div>

        <div class="ui left aligned list" each={ tasks }>
          <div class="item">
            <div class="left floated content">
              <div class="ui large checkbox" >
                <input type="checkbox" checked={ done } onclick={ toggle } >
                  <label><h3>{ task }</h3></label>
                </input>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

    this.on('mount', function(){
      //console.log( $('.menu .item')) ;
      $('.ui.checkbox').checkbox();
      $('.menu').on('click', '.item', function() {
        $(this).addClass('active')
              .siblings('.item')
              .removeClass('active');
      });
    });

  	this.tasks = [] ;
    this.total = [] ;
    this.asked = 'PENDING';

  	addTask( e ){
    		var text = e.target[0] ;
    		if(text.value!=''){
          	this.total.push( { task:text.value , done:false } ) ;
      			text.value = ''
    		}else{
             this.total = this.total ;
    		}
        this.updateList() ;
  	}

  	toggle( e ){
    		var task = e.item ;
    		task.done = !task.done ;
        this.updateList();
  	}

  	updateList(){
      if( this.asked==='PENDING'){
          this.tasks = this.total.filter( this.isTaskNotDone ) ;
          this.showPendingTasks() ;
      }
      else if( this.asked==='FINISHED'){
          this.tasks = this.total.filter( this.isTaskDone ) ;
          this.showFinishedTasks()
      }
      else if( this.asked==='ALL'){
          this.tasks = this.total ;
          this.showAllTasks() ;
      }
  	}

  	isTaskNotDone( task ){
    		if( !task.done )
    			 return true
    		else
    			 return false
  	}

  	isTaskDone( task ){
    		if( task.done )
    			 return true
    		else
    			 return false
  	}

    showPendingTasks(  ){
        this.asked = 'PENDING' ;
        this.tasks = this.total.filter( this.isTaskNotDone ) ;
    }

    showFinishedTasks(  ){
        this.asked = 'FINISHED' ;
        this.tasks = this.total.filter( this.isTaskDone ) ;
    }

    showAllTasks(  ){
        this.asked = 'ALL' ;
        this.tasks = this.total ;
    }

</todo>
