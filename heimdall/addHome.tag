<!--
Second child of "home" tag.
-Homepage of addFeature. Here a product is chosen, for which we wish to add a new feature.
-This tag also has a child tag which shows all the parameters required for creating a new feature.
-->
<addHome>

    <div class="ui center aligned basic segment" id="chose">
        <div class="ui form">
            <div class="inline field">
    		    <label>Product</label>
        		<div class="ui large loading search selection dropdown" id="productDropdown" onclick={ confimLeave } onchange={ showNameForm }>
        		    <input type="hidden" name="ProductName">
        		    <i class="dropdown icon"></i>
        		    <div class="default text">Select a product</div>
        		    <div class="menu">
        			    <div class="huge item" each={item, index in allProducts}><i class="cube icon"></i>{ item }</div>
        		    </div>
        		</div>
            </div>
        </div>

    	<div class="ui basic center aligned segment">
    	    <form class="ui large form" onsubmit={ validateName } id="conditions1">
    	    	<div class="ui input field">
                    <input placeholder="Feature name goes here" type="text" id="feaName" data-content="Enter feature name here" data-variation="small inverted">
    		</div>
                <input class="ui button blue field" type="submit" value="Save">
    	    </form>
    	</div>
    </div>

    <div class="ui grid">
        <div class="ui one wide column"></div>
        <div class="ui fourteen wide column">
            <div id="conditions"></div>
        </div>
        <div class="ui one wide column"></div>
    </div>

    <div class="ui small modal" id="confirmNewFeature">
        <div class="header">Create New Feature</div>
        <div class="content">
            <div class="description">
                <div class="ui header">Add feature: { featureName }.</div>
                <p>Are you sure you really want to add this feature?</p>
            </div>
        </div>
        <div class="actions">
            <div class="ui black deny button" onclick={ dontCreate }>Nope</div>
            <div class="ui positive right labeled icon button" onclick={ createFeature }>Yep, add this feature.<i class="checkmark icon"></i></div>
        </div>
    </div>

    <div class="ui center aligned red inverted segment" id="errors">
    <div class="ui center aligned header" id="errorMsg"></div>
    </div>

    <script>
    this.areConditionsMounted = false;
    this.productName = '' ;
    this.featureName = '' ;
    this.featureID = '' ;
    $(this.on('mount',function(){
        $('.ui.dropdown').dropdown();
        $("#feaName").popup();
        $('#conditions1').hide();
        $('#errors').hide();
        $.get("/v2/get_all_products", this.showProducts ).fail(function($xhr) {
            var data = $xhr.responseJSON;
            console.log(data);
            $('#errorMsg').html( data.message );
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
        });
    }));

    //loads the list of products into the dropdown menu.
    showProducts( data, status ){
        this.allProducts = data.products ;
        this.update();
        $('#productDropdown').removeClass('loading');
    }

    showNameForm( e ){
        this.productName = e.target.value.replace('<i class="cube icon"></i>', '') ;
        $('#conditions1').show() ;
    }

    validateName( e ){
        if( e.target[0].value == '' ){
            $('#errorMsg').html( "Please enter a valid name" );
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
            return ;
        }
        this.featureName = e.target[0].value ;
        $('.ui.small.modal#confirmNewFeature')
            .modal('setting', 'closable', false)
            .modal('show');
    }

    dontCreate(){
        $('.ui.small.modal#confirmNewFeature').modal('hide');
        $('.ui.small.modal#confirmProceed').modal('hide');
    }

    createFeature(){
        var tempFeature = { name:'' , conditions:[] , owners:[] , enabled_for_count:0 , enabled_for_primary_key:[] , enable_for_primary_key:[] , relation:"" , py_relation:"" } ;
        tempFeature.name = this.featureName ;
        var param = { product_name:this.productName , feature:tempFeature } ;
        $.ajax({
            url: '/v2/add_feature',
            type: 'post',
            dataType: 'json',
            success: this.getFeatureID ,
            contentType: "application/json",
            data: JSON.stringify(param)
        }).fail(function($xhr) {
            var data = $xhr.responseJSON;
            console.log(data);
            $('#errorMsg').html( data.message );
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
        });
    }

    leaveFeature(){
        $('conditions_modify').detach();
        this.areConditionsMounted = false ;
        $('#feaName').val('');
        this.featureName = '' ;
    }

    confimLeave(){
        if( this.areConditionsMounted ){
            $('.ui.small.modal#confirmProceed')
                .modal('setting', 'closable', false)
                .modal('show');
        }
    }

    getFeatureID( data ,status ){
        this.featureID = data.data.id ;
        $.get("/v2/get_feature_details", { product_name:this.productName , feature_id:this.featureID } , this.mountConditions ).fail(function($xhr) {
            var data = $xhr.responseJSON;
            console.log(data);
            $('#errorMsg').html( data.message );
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
        });
    }

    mountConditions(){
        $('#conditions').html('<conditions_modify></conditions_modify>');
        riot.mount('conditions_modify',{ product_name:this.productName , feature_id: this.featureID });
        this.areConditionsMounted = true ;
    }

    </script>
</addHome>
