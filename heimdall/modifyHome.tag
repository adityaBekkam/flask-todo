<!--
First child of "home" tag.
-Homepage of modifyFeature. Here a product and an associated feature which is to be modified, is chosen.
-Has a child tag which updates the selected feature( if modified ).
-->
<modifyHome>

    <div class="ui center aligned basic segment" id="chose">
        <div class="ui large search selection loading dropdown" id="productDropdown" onchange={ choseProduct }>
            <input type="hidden" name="productName">
            <i class="dropdown icon"></i>
            <div class="default text">Product</div>
            <div class="menu">
                <div class="huge item" each={item, index in allProducts}><i class="cube icon"></i>{ item }</div>
            </div>
        </div>

        <div class="ui large search selection dropdown" onchange={ mountConditions } id="featureDropdown">
            <input type="hidden" id="featureName">
            <i class="dropdown icon"></i>
            <div class="default text" id="selectFeature">Feature</div>
            <div class="menu">
                <div class="item" each={item, index in allFeatures}><i class="right arrow icon"></i>{ item.name }</div>
            </div>
        </div>
    </div>
    <div class="ui grid">
        <div class="ui one wide column"></div>
        <div class="ui fourteen wide column">
            <div class="" id="conditions"></div>
        </div>
        <div class="ui one wide column"></div>
    </div>

    <div class="ui center aligned red inverted segment" id="errors">
        <div class="ui center aligned header" id="errorMsg"></div>
    </div>

    <script>
    this.allProducts = [] ;
    this.allFeatures = [] ;
    this.productName = "" ;
    this.featureID = "" ;

    $(this.on('mount',function(){
        $('.ui.dropdown').dropdown();
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

    //loads the list of produts into the dropdown menu.
    showProducts( data, status ){
        this.allProducts = data.products ;
        this.update();
        $('#productDropdown').removeClass('loading');
    }

    //Gets all the features of the selected product.
    choseProduct(e){
        $('#featureDropdown').addClass('loading');
        if( this.productName != '' ){
            if( this.featureID != "" ){
                this.featureID = "" ;
                $('conditions_modify').detach();
                $('#featureName').val('') ;
            }
        }
        this.productName = e.target.value.replace('<i class="cube icon"></i>', '');
        $('#selectFeature').html("Feature");
        this.allFeatures = [] ;
        $.get("/v2/get_features?", { product_name:this.productName } , this.showFeatures ).fail(function($xhr) {
            var data = $xhr.responseJSON;
            console.log(data);
            $('#errorMsg').html( data.message );
            $('#errors').transition({ animation:'fade up' } );
                setTimeout(function(){
            $('#errors').transition({ animation:'fade up' } );
            }, 5000);
        });
    }

    //loads the list of features into the dropdown menu.
    showFeatures( data ,status ){
        if( data.features != null ){
            if( data.features[0] != null ){
                if( data.features[0].name != null ){
                    this.allFeatures = data.features ;
                }
            }
        }
        this.update();
        $('#featureDropdown').removeClass('loading');
    }

    //mounts the conditions of the selected feature("conditions_modify")
    mountConditions( e ){
        $('#productDropdown').removeClass('loading');
        var newFeature = e.target.value.replace('<i class="right arrow icon"></i>', '');
        if( this.featureID != '' ){
            $('conditions_modify').detach();
        }
        for(i = 0; i < this.allFeatures.length; i++){
            if( this.allFeatures[i].name === newFeature ){
                this.featureID = this.allFeatures[i]._id.$oid ;
                break ;
            }
        }
        $('#conditions').html('<conditions_modify></conditions_modify>');
        riot.mount('conditions_modify',{ product_name:this.productName , feature_id: this.featureID });
    }
    </script>
</modifyHome>
