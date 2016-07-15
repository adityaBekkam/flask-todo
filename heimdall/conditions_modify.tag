<!--
Child tag of "modifyHome" tag.
-This tag displays all the information about the selected feature.
-Takes the info we wish to modify and updates the feature.
-->
<conditions_modify>
    <div class="ui two column padded grid stackable">
        <div class="row">
            <div class="one field twelve wide column" id="conditions">
                <h2 class="ui left aligned blue inverted header">
                    <div class="content"><i class="settings icon"></i>Configure the conditions</div>
                </h2>
                <p class="extra"><i><b>This feature will be shown to the users based on these conditions.</b></i></p>
                <div class="ui divider"></div>

                <div>
                    <div class="ui large loading form">
                        <div class="fields">
                            <div class="field">
                            <h2  class="ui left aligned grey header">
                                <div class="content" id="text"><i class="anchor icon"></i>{ this.keyName }</div>
                            </h2>
                            <p class="extra"><i><span>Comma separated {this.keyName} for which this feature should be enabled.</span></i></p>
                            </div>
                            <div class="eleven wide field">
                                <form class="ui large center aligned form" onsubmit= { addNewKey1 }>
                                    <div class="one field">
                                        <div class="field">
                                            <input id="newKeys" type="text" value={ feature.enable_for_primary_key.toString() } data-content="Add {this.keyName} here" data-variation="small inverted">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="ui basic fluid right aligned segment" style="margin: 0; padding: 0;">
                        <p>
                            This feature is enabled for <a class="ui small orange circular label">{ feature.enabled_for_count }</a> users.&nbsp&nbsp&nbsp
                            <a href="#" id="indexing" data-content="Clear all users from Heimdall's index" data-variation="small inverted" onclick={clearKeys}>Clear</a>&nbsp&nbsp&nbsp
            		    <a href="#" id="download" data-content="Download all {this.keyName}" data-variation="small inverted" onclick={}>Download</a>
                        </p>
                        </div>
                    </div>
                    <h3 class="ui center aligned header">Or</h3>
                    <div>
                        <div class="ui basic segment" id="builder"></div>
                    </div>

                    <div class="ui hidden divider"></div>
                    <div>
        		    	<div class="ui checkbox" id="askCount" >
          			        <input type="checkbox" name="count" onchange={showCount}>
         		    	    <label><h3 style="display:inline; font-weight:normal">Do you want to restrict the number of users to access this feature? &nbsp;</h3></label>
        			    </div>
                        <div class="ui field input" id="showCount">
                            <input class="ui large input" type="number" min="1" id="count"  placeholder="count">
                        </div>
                    </div>

                    <div class="ui hidden divider"></div>
                    <div class="ui form" id="checkboxes">
                        <div class="inline fields">
                            <label><h3 style="font-weight:normal">Do you want to enable/disable feature for the above rules?</h3></label>
                            <div class="field">
                                <div class="ui radio checkbox">
                                    <input type="radio" name="radio-box" onchange={toggleCheckbox} checked={feature.is_enabled}>
                                    <label><h3 style="font-weight:normal">Enable</h3></label>
                                </div>
                            </div>
                            <div class="field">
                                <div class="ui radio checkbox">
                                    <input type="radio" name="radio-box" onchange={toggleCheckbox} checked={!enable}>
                                    <label><h3 style="font-weight:normal">Disable</h3></label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ui hidden divider"></div>

                    <div class="ui basic segment right aligned">
                        <button class="ui basic large grey button" id="cancelButton" onclick={ clarifyCancel }>Cancel</button>
                        <button class="ui large blue button" id="saveButton" onclick={ checkValues }>Save</button>
                    </div>
                </div>
            </div>
            <div class="ui green vertical divider"></div>

            <div class="one field four wide column" id="owners">
                <h2 class="ui left aligned blue inverted header">
                    <div class="content"><i class="user icon"></i>Featue Owners</div>
                </h2>
                <div class="ui divider"></div>
                <div class="ui left aligned list"  each={ item, index in feature.owners }>
                    <div class="item">
			<h3 style="display:inline; font-weight:normal">{item}</h3>
                        <button class="ui basic right floated small grey icon button" onclick={ removeUser }><i class="remove icon"></i></button>
                    </div>
                </div>
                <div class="ui grey header" id="message"><h3>No Owners</h3></div><br>
                <button class="ui right floated blue icon button" id="addUserButton" onclick={ enableForm }>Add Owner <i class="add user icon"></i></button><br><br>

                <form class="ui large form padded" id="newOwnerForm" onsubmit={ addOwner }>
                    <div class="one field">
                        <div class="field">
                            <label>Email ID</label>
                            <input placeholder="Practo Email ID goes here" type="text">
                        </div>
                    </div>
                    <input class="ui small grey right floated basic button" type="submit" value="Save">
                    <a class="ui small grey right floated basic button" onclick={ disableForm }>Cancel</a>
                </form>

            </div>
        </div>
    </div>

    <div class="ui center aligned green inverted segment" id="progress">
        <div class="ui center aligned small header" id="successMsg">Saved.</div>
    </div>

    <div class="ui center aligned red inverted segment" id="errors">
        <div class="ui center aligned small header" id="errorMsg">Enter valid conditions as rules.</div>
    </div>

    <div class="ui small modal" id="confirmClear">
        <div class="header">
        Clear all users from Heimdall Index
        </div>
        <div class="content">
        <div class="description">
        <div class="ui header">You are about to clear all enabled users for this feature from Heimdall's Index.</div>
        <p>Are you sure you really want to make these changes?</p>
        </div>
        </div>
        <div class="actions">
            <div class="ui black deny button" onclick={ dontSave }>Nope</div>
            <div class="ui positive right labeled icon button" onclick={ saveFeature }>Yep, clear.<i class="checkmark icon"></i></div>
        </div>
    </div>

    <div class="ui small modal" id="confirmUpdate">
        <div class="header">
        Save this feature
        </div>
        <div class="content">
        <div class="description">
        <p>Are you sure you really want to save these changes?</p>
        </div>
        </div>
        <div class="actions">
            <div class="ui black deny button" onclick={ dontSave }>Nope</div>
            <div class="ui positive right labeled icon button" onclick={ saveFeature }>Yep, save changes.<i class="checkmark icon"></i></div>
        </div>
    </div>

    <div class="ui small modal" id="confirmCancel">
        <div class="header">Discard changes made for this feature</div>
        <div class="content">
            <div class="description">
                <p>Are you sure you want to discard these changes?</p>
            </div>
        </div>
        <div class="actions">
            <div class="ui black deny button" onclick={ dontSave }>Nope</div>
            <div class="ui positive right labeled icon button" onclick={ discard }>Yep, discard my changes.<i class="checkmark icon"></i></div>
        </div>
    </div>

    <script>
    this.product = opts.product_name ;
    this.feature = {} ;
    this.keyName = "" ;
    this.strRelation = "" ;
    this.numOfConds = 0 ;
    this.conditions = [] ;
    
    //parameters for setting up filters.
    this.options = {
        allow_empty: true,
        sort_filters: true,
        operators: [
        {type: 'equal'           },
        {type: 'not_equal'       },
        {type: 'in'              },
        {type: 'not_in'          },
        {type: 'less'            },
        {type: 'less_or_equal'   },
        {type: 'greater'         },
        {type: 'greater_or_equal'},
        {type: 'between'         },
        {type: 'not_between'     },
        {type: 'begins_with'     },
        {type: 'not_begins_with' },
        {type: 'contains'        },
        {type: 'not_contains'    },
        {type: 'ends_with'       },
        {type: 'not_ends_with'   },
        {type: 'is_empty'        },
        {type: 'is_not_empty'    },
        {type: 'is_null'         },
        {type: 'is_not_null'     }
        ],
        filters: []
    } ;

    setAttr(){
        $('.ui.dropdown').dropdown( {allowAdditions:true });
        $('#indexing').popup() ;
        $('#download').popup() ;
        $('#newKeys').popup() ;
    	$('#askCount').checkbox();
        $('#newOwnerForm').hide() ;
        $('#progress').hide();
        $('#errors').hide();
        $('#showCount').hide();
    }

    $(this.on('mount',function(){
        this.setAttr();
        $.get("/v2/get_all_features_and_constraints" , { product_name:opts.product_name }, function(response, status) {
            this.setFiltersList(response, status);
            $.get("/v2/get_feature_details", { product_name:opts.product_name ,feature_id:opts.feature_id }, function(response, status) {
                this.showConditions(response, status);
            }.bind(this));
        }.bind(this));
    }));

    //setting up filters.
    setFiltersList( data,status ){
	this.keyName = data.constraints[0] ;
	data.constraints = data.constraints[1] ;
        //console.log( data.constraints );
        var i ;
        for(i = 0; i < data.constraints.length; i++){
            if( data.constraints[i].name != "count" ){
                var temp = {
                    id: data.constraints[i].name ,
                    label: data.constraints[i].display_text,
                    type: '' ,
                    validation: {} ,
                    values: {} ,
                    colors: {} ,
                    operators: [] ,
                    input: "" ,
                    placeholder: "" ,
                    size: 40 ,
                    rows: 2
                };
                for(name in data.constraints[i].operators){
                    var op = data.constraints[i].operators[name] ;
                    switch ( op ) {
                        case '=' :
                            op = 'equal' ;
                            break;
                        case '!=' :
                            op = 'not_equal' ;
                            break;
                        case '<' :
                            op = 'less_or_equal' ;
                            break;
                        case '<=' :
                            op = 'less_or_equal' ;
                            break;
                        case '>' :
                            op = 'greater_or_equal' ;
                            break;
                        case '<' :
                            op = 'greater_or_equal' ;
                            break;
                        case 'is' :
                            op = 'equal' ;
                            break;
                        case 'contains' :
                            temp.contains = true ;
                            op = 'equal' ;
                            break;
                        default:
                    }
                    var j ;
                    var flag=0 ;
                    for(j = 0; j < this.options.operators.length; j++){
                        if( this.options.operators[j].type === op ){
                            flag = 1 ;
                            break ;
                        }
                    }
                    if( flag === 0 ){
                        this.options.operators.push( { type:op , nb_inputs:1 , muliple:true , apply_to:['string','number','boolean'] } ) ;
                    }
                }
                temp.operators.push( op ) ;
                switch ( data.constraints[i].value ) {
                    case "bool" :
                        temp.input = 'radio' ;
                        temp.type = 'integer' ;
                        temp.values = { 1:"True" , 2:"False" } ;
                        break;
                    case "int" :
                        temp.input = 'text' ;
                        temp.type = 'integer' ;
                        temp.validation = { min:0 } ;
                        temp.placeholder = 'Enter value' ;
                        break;
                    case "list" :
                        temp.input = 'textarea' ;
                        temp.type = 'string' ;
                        temp.placeholder = 'csv' ;
                        temp.rows = 2 ;
                        break;
                    case "unicode" :
                        temp.input = 'textarea' ;
                        temp.type = 'string' ;
                        temp.placeholder = 'Unicode value' ;
                        break;
                    default :
                        temp.input = 'textarea' ;
                        temp.type = 'string' ;
                        temp.rows = 2 ;
                }
                this.options.filters.push( temp ) ;
            }
        }
        if( this.options.filters.length!=0 )
            $('#builder').queryBuilder( this.options );
        else
            $('#builder').html('<h3>No filters to show</h3>');
        this.update() ;
    }

    //loads the existing data about the selected feature.
    showConditions( data,status ){
	console.log(data);
        this.feature = data.feature ;
        if( this.feature.owners.length > 0 )
            $('#message').hide() ;
        $('.ui.large.form').removeClass('loading');
        if( this.feature.relation == "" ){
            this.update() ;
            return ;
        }
        if( this.feature.conditions[ this.feature.conditions.length-1 ].vector_name === "count" ){
            if( this.feature.relation.length>7 )
                this.feature.relation = this.feature.relation.substring( 0 , this.feature.relation.length-7 );
             else
                this.feature.relation = "" ;
	    $('#askCount input').prop('checked',true);
            $('#count').val( this.feature.conditions[ this.feature.conditions.length-1 ].value ) ;
            this.showCount();
        }
        if( this.feature.relation!="" && this.options.filters.length!=0 ){
            var rulesJSON = this.getConditionsArray( this.feature.relation , 0 , this.feature.relation.length-1 ) ;
            $('#builder').queryBuilder('setRules', rulesJSON);
            this.getRules();
        }
	//this.enable = this.feature.enable ;
        this.update() ;
    }

    //loads the existing relation into the builder.
    getConditionsArray( arr , start, end ) {
        var obj = {condition:"AND" , rules:[{}] };
	if( start>=end ){
	   return obj;
	}
        var i ;
        var count = 0 ;
        for(i = start; i <= end; i++){
            if( arr[i] == '('){
                var temp = i+1 ;
                var flag = 0 ;
                while( !(flag == 0 && arr[temp] == ')' ) ){
                    if( arr[temp] == '(' ){
                        flag++ ;
                    }
                    if( arr[temp] == ')' ){
                        flag-- ;
                    }
                    temp++ ;
                }
                obj.rules[count]=this.getConditionsArray( arr , i+1 ,temp-1 ) ;
                count++ ;
                i = temp ;
            }
            else if( arr[i] == 'c' ){
                var temp = i+1 ;
                var tempStr = "" ;
                while( arr[temp] != ' ' && temp <= end ){
                    temp++ ;
                }
                tempStr = arr.substring( i , temp );
                obj.rules[count] = this.getCondition( tempStr );
                count++ ;
                i=temp ;
            }
            else if( arr[i] == 'a' ){
                obj.condition = "AND" ;
                i = i+2 ;
            }
            else if( arr[i] == 'o' ){
                obj.condition = "OR" ;
                i = i+1 ;
            }
        }
        return obj ;
    }

    //gets the condition whose _id = str
    getCondition( str ){
        var index = ( parseInt( str.substring(1,str.length))-1) ;
        var con = {
            id: this.feature.conditions[index].vector_name ,
            operator: this.feature.conditions[index].operator ,
            value: this.feature.conditions[index].value
        }
        switch( con.operator ){
            case 'is' :
                con.operator = 'equal' ;
                if( con.value==false )
                    con.value = 2 ;
                else
                    con.value = 1 ;
                break;
            case '<=' :
                con.operator = 'less_or_equal' ;
                break;
            case '<' :
                con.operator = 'less_or_equal' ;
                break;
            case '>=' :
                con.operator = 'greater_or_equal' ;
                break;
            case '>' :
                con.operator = 'greater_or_equal' ;
                break;
            case 'contains' :
                con.operator = 'equal' ;
                break;
            case 'in' :
                con.value = con.value.toString() ;
            default :
        }
        return con;
    }

    //getting final evaluated rule from builder.
    getRules(){
        if( this.options.filters.length!=0 ){
            var tempJson = JSON.stringify($('#builder').queryBuilder('getRules', {get_flags: true}),undefined, 2) ;
            if( tempJson == "{}" ){
                return -1;
            }
            var res = $('#builder').queryBuilder('getSQL', $(this).data('stmt'), false);
            var string = res.sql + (res.params ? '\n\n' + JSON.stringify(res.params, undefined, 2) : '') ;
            this.conditions = [] ;
            this.numOfConds = 0 ;
            this.storeConditions( JSON.parse(tempJson) );
            this.getStringRelation( string );
        }
        else{
            this.conditions = [] ;
            this.numOfConds = 0 ;
        }
        if( $('#count')[0].value != '' ) {
            this.conditions[ this.numOfConds ] = {
                condition_name: "c" + (this.numOfConds+1) ,
                vector_name: "count",
                operator: "<=",
                value: parseInt( $('#count')[0].value)
            };
            if( this.strRelation==="" )
                this.strRelation = this.conditions[ this.numOfConds ].condition_name ;
            else
                this.strRelation = this.strRelation + " and " +  this.conditions[ this.numOfConds ].condition_name ;
            this.numOfConds++ ;
        }
    }

    //final relation in string format ( relations are denoted by their id's ).
    getStringRelation( str ){
        str = str.split(" ") ;
        var tempStr = "";
        var i ;
        for(i = 0; i < str.length; i++){
            switch (str[i]) {
                case "AND" :
                    tempStr = tempStr.concat( " and " );
                    break;
                case "OR" :
                    tempStr = tempStr.concat( " or " );
                    break;
                case "(" :
                    tempStr = tempStr.concat( "(" );
                    break ;
                case ")" :
                    tempStr = tempStr.concat( ")" );
                    break ;
                default :
                    var j ;
                    for(j = 0; j < this.conditions.length; j++){
                        if( this.conditions[j].vector_name === str[i] ){
                            tempStr = tempStr.concat( this.conditions[j].condition_name ) ;
                            break ;
                        }
                    }
            }
        }
        this.strRelation = tempStr ;
    }

    //stores the conditions in heimdall specified format
    storeConditions( arr ){
        var flag = false ;
        var k = 0 ;
        this.numOfConds = 0;
        for(k = 0; k < (arr.rules.length); k++,this.numOfConds++){
            var temp = arr.rules[k] ;
            this.conditions[ this.numOfConds ] = {
                condition_name: "c" + (this.numOfConds+1)  ,
                vector_name: temp.id,
                operator: '',
                value: temp.value
            };
            switch ( temp.type ) {
                case 'integer' :
                    this.conditions[ this.numOfConds ].value = parseInt( temp.value ) ;
                    break ;
                case 'string' :
                    if( temp.input === 'textarea' && temp.operator === 'equal' ){
                        flag = true;
                        this.conditions[ this.numOfConds ].value = temp.value ;
                    }
                    else
                        this.conditions[ this.numOfConds ].value = temp.value.split(',') ;
                    break ;
                default:
            }
            switch ( temp.input ) {
                case 'radio' :
                    if( temp.value === '1' )
                        this.conditions[ this.numOfConds ].value = true ;
                    else
                        this.conditions[ this.numOfConds ].value = false ;
                    break;
                default :
            }
            switch (temp.operator) {
                case 'equal' :
                if( flag )
                    this.conditions[ this.numOfConds ].operator = 'contains' ;
                else
                    this.conditions[ this.numOfConds ].operator = 'is' ;
                    break;
                case 'less' :
                    this.conditions[ this.numOfConds ].operator = '<=' ;
                    break;
                case 'less_or_equal' :
                    this.conditions[ this.numOfConds ].operator = '<=' ;
                    break;
                case 'greater' :
                    this.conditions[ this.numOfConds ].operator = '<=' ;
                    break;
                case 'greater_or_equal' :
                    this.conditions[ this.numOfConds ].operator = '<=' ;
                    break;
                default :
                    this.conditions[ this.numOfConds ].operator = temp.operator ;
            }
        }
    }

    clearKeys(){
	this.feature.clear_indexing = true ;
        var error = false ;
        if( this.getRules() == -1){
            $('#errorMsg').html('Enter valid rules');
            error = true ;
        }
        if( error ){
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
            return  ;
        }
        $('.ui.small.modal#confirmClear')
            .modal('setting', 'closable', false)
            .modal( {allowMultiple:false} )
            .modal('show');
    }

    showCount(){
	if( !$('#askCount input').prop("checked") ){
	    $('#count').val('');
	}
        $('#showCount').toggle();
    }

    toggleCheckbox(e){
        this.feature.is_enabled = !this.feature.is_enabled ;
    }

    clarifySave(){
        $('.ui.small.modal#confirmUpdate')
        .modal('setting', 'closable', false)
        .modal( {allowMultiple:false} )
        .modal('show');
    }

    clarifyCancel(){
        $('.ui.small.modal#confirmCancel')
        .modal('setting', 'closable', false)
        .modal( {allowMultiple:false} )
        .modal('show');
    }

    dontSave(){
        $('.ui.small.modal#confirmClear').modal('hide');
        $('.ui.small.modal#confirmUpdate').modal('hide');
        $('.ui.small.modal#confirmCancel').modal('hide');
    }

    checkValues(){
        var error = false ;
        if( this.getRules() == -1){
            $('#errorMsg').html('Enter valid rules');
            error = true ;
        }
        else{

        }
        if( error ){
            $('#errors').transition({ animation:'fade up' } );
            setTimeout(function(){
                $('#errors').transition({ animation:'fade up' } );
            }, 5000);
            return  ;
        }
        this.clarifySave();
    }

    addNewKey1( e ){
    //console.log( e.target[0].value.split(',') );
    }

    deleteKey( e ){
        this.feature.enable_for_primary_key.splice( e.item.i , 1) ;
    }

    //enables the form for adding new owners.
    disableForm() {
        $('#newOwnerForm').toggle();
    }

    //enables the form for adding new owners.
    enableForm() {
        $('#newOwnerForm').toggle();
    }

    //adding new owners for the feature.
    addOwner( e ){
        var newUser = e.target[0].value ;
        if( newUser != ''){
            this.feature.owners.push( newUser ) ;
            newUser = '' ;
            e.target[0].value = '' ;
            this.updateOwners();
        }
        if( this.feature.owners.length > 0 ){
            $('#message').hide();
        }
        else{
            $('#message').show() ;
        }
    }

    //removes the selected user.
    removeUser(e){
        this.feature.owners.splice( e.item.index , 1) ;
        if( this.feature.owners.length > 0 ){
            $('#message').hide() ;
        }
        else{
            $('#message').show() ;
        }
        this.updateOwners() ;
    }

    //updating the feature in the server.
    saveFeature(){
        this.feature.conditions = this.conditions ;
        this.feature.is_enabled = this.feature.is_enabled ;
        this.feature.relation = this.strRelation ;
        this.feature.enable_for_primary_key = $('#newKeys')[0].value.split(",") ;
        console.log( this.feature );
        var param = { product_name:opts.product_name , feature:this.feature , feature_id:opts.feature_id } ;
        $.ajax({
            url: '/v2/add_feature',
            type: 'post',
            dataType: 'json',
            success: this.showStatus ,
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

    showStatus( data,status ){
        $('.ui.small.modal#confirmClear').modal('hide');
        $('.ui.small.modal#confirmUpdate').modal('hide');
        $('#progress').transition({ animation:'fade up' } );
        setTimeout(function(){
            $('#progress').transition({ animation:'fade up' } );
        }, 3000);
        this.update();
    }

    //discards the changes made to the feature
    discard(){
        $('.ui.small.modal#confirmCancel').modal('hide');
        this.unmount();
    }

    //updates the owners list in the server.
    updateOwners(){
        var payload = { product_name:opts.product_name ,feature_id:opts.feature_id , owners:this.feature.owners };
        $.ajax({
            url: '/v2/update_owners',
            type: 'post',
            dataType: 'json',
            success: this.newOwners,
            contentType: "application/json",
            data: JSON.stringify(payload)
        });
    }

    newOwners( data ,status ){
        this.update();
    }

    </script>
</conditions_modify>
