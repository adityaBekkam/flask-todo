
<adminHome>
    <div class="ui basic center aligned segment">
        <form class="ui large form" onsubmit={ getUserDetails } id="conditions1">
    	   	<div class="ui input field">
                <input placeholder="Email id goes here" type="text" id="user-email" data-content="Enter email id here" data-variation="small inverted">
    		</div>
            <input class="ui button blue field" type="submit" value="Search">
    	</form>
    </div>

    <div class="ui equal width form" id="user-info" >
        <div class="fields">
            <div class="field"></div>
            <div class="field">
                <label>User Email</label>
                <input type="text" readonly="" value={user.email}>
            </div>
            <div class="field"></div>
        </div>

      <div class="fields">
          <div class="field"></div>
          <div class="field">
              <label>Products Owned</label>
              <input type="text" id="products" placeholder="Products" value={user.product.toString()}>
          </div>
          <div class="field"></div>
      </div>

      <div class="fields">
          <div class="field"></div>
          <div class="field">
        	  <div class="grouped fields">
                  <label for="role">User role:</label>
                  <div class="field" onchange={setRole}>
                      <div class="ui radio checkbox">
                            <input type="radio" name="role" value="admin" checked={user.role=='admin'} tabindex="0" class="hidden">
                            <label>Admin</label>
                      </div>
                  </div>
                  <div class="field" onchange={setRole}>
                      <div class="ui radio checkbox">
                            <input type="radio" name="role" value="product_admin" checked={user.role=='product_admin'} tabindex="0" class="hidden">
                            <label>Product Admin</label>
                      </div>
                </div>
                <div class="field" onchange={setRole}>
                    <div class="ui radio checkbox">
                        <input type="radio" name="role" value="gatekeeper"  checked={user.role=='gatekeeper'} tabindex="0" class="hidden">
                        <label>Gatekeeper</label>
                    </div>
                </div>
            </div>
        </div>
         <div class="field"></div>
        </div>
    </div>

    <div class="ui center aligned basic segment" id="save">
        <div class="ui large blue button" onclick={saveUser}>Save</div>
        <div class="ui basic large button" onclick={cancel}>Cancel</div>
    </div>

    <div class="ui center aligned green inverted segment" id="progress">
        <div class="ui center aligned header" id="successMsg">Role updated.</div>
    </div>

    <div class="ui center aligned red inverted segment" id="errors">
        <div class="ui center aligned header" id="errorMsg"></div>
    </div>

    <script>
    this.user = {} ;

    $(this.on('mount',function(){
        $('.ui.dropdown').dropdown();
        $("#user-email").popup();
	$('.ui.radio.checkbox').checkbox();
	$('#save').hide();
	$('#user-info').hide();
	$('#errors').hide();
	$('#progress').hide();
	$('#user-info').addClass("loading");
    }));

    getUserDetails(e){
	var user = document.getElementById('user-email').value ;
	$('#save').hide();
	$('#user-info').hide();
	$.get("/v2/get_user",{"email":user}, this.showUser ).fail(function($xhr) {
            var data = $xhr.responseJSON;
            $('#errorMsg').html( data.message );
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
        });
    }

    saveUser(){
	var temp =  document.getElementById('products').value;
	if( temp==="" ){
	    temp = [] ;
	}
	else{
	    temp = temp.split(',');
	}
 	var param = { email:this.user.email , product:temp , role:this.user.role } ;
	//console.log( param );
        $.ajax({
            url: '/v2/change_role',
            type: 'post',
            dataType: 'json',
            success: this.showStatus ,
            contentType: "application/json",
            data: JSON.stringify(param)
        }).fail(function($xhr) {
            var data = $xhr.responseJSON;
            //console.log(data);
            $('#errorMsg').html( data.message );
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
        });
    }

    showStatus(data,status){
        $('#progress').transition({ animation:'fade up' } );
        setTimeout(function(){
            $('#progress').transition({ animation:'fade up' } );
        }, 3000);
    }

    cancel(){
	this.user = {} ;
	$('#save').hide();
	$('#user-info').hide();
    }

    setRole(e){
	this.user.role = e.target.value ;
    }

    showUser(data,status){
	//console.log(data);
	this.user = data ;
	$('#user-info').show();
	$('#save').show();
	$('#user-info').removeClass("loading");
	this.update();
    }

    </script>
</adminHome>
