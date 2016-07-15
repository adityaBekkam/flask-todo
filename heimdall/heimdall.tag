<!--
This tag(home) consists of two child tags( addHome, modifyHome) which are mounted based on our purpose.
By default, homepage for modifying a feature is shown.
-->
<home>

    <div class="ui grey">
        <div class="ui black borderless stackable menu">
            <div class="item">
                <h1 class="ui left aligned blue inverted header">Heimdall</h1>
            </div>
            <a class="active item" id="modifyF" onclick={ mountModify } data-variation="tiny inverted" data-content="Click here to edit any feature" data-position="bottom center">
                <div class="ui grey header">
                    <h4><i class="edit grey icon"></i>Modify Feature</h4>
                </div>
            </a>
            <a class="item" id="addF" onclick={ mountAdd } data-content="Click here to add a new feature" data-variation="tiny inverted" data-position="bottom center">
                <div class="ui grey header">
                    <h4><i class="plus square outline grey icon"></i>Add Feature</h4>
                </div>
            </a>
            <a class="item" id="admin" onclick={ mountAdminPage } data-variation="tiny inverted" data-content="Manage user roles and authorization" data-position="bottom center">
                <div class="ui grey header">
                    <h4><i class="spy grey icon"></i>User Management</h4>
                </div>
            </a>
            <div class="ui right aligned dropdown item" id="userProfile">
                <div class="text" id="currentUser">
                    <h4 class="ui header">{opts.user}</h4>
                </div>
                <i class="dropdown icon"></i>
                <div class="menu">
                    <a class="item" id="signoutBtn">
                        <h4 class="ui header">Sign Out</h4>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <modifyHome></modifyHome>

    <script>
    this.isAddPresent = false ;
    this.isModifyPresent = true ;
    this.isAdminPresent = false;

    $(this.on('mount',function(){
        $('.ui.dropdown').dropdown();
        $('.item#admin').popup();
        $('.item#modifyF').popup();
        $('.item#addF').popup();
    }));

    //mounting "addHome"
    mountAdd(){
        if( this.isAddPresent ){
            return ;
        }
        $('modifyHome').detach() ;
	    $('adminHome').detach();
        $('#addF').addClass('active')
            .siblings('.item')
            .removeClass('active');
        $('home').append("<addHome></addHome>") ;
        riot.mount('addHome');
        this.isAdminPresent = false ;
        this.isAddPresent = true ;
        this.isModifyPresent = false ;
    }

    mountAdminPage(){
        if( this.isAdminPresent ){
            return ;
        }
        $('modifyHome').detach() ;
	    $('addHome').detach();
        $('#admin').addClass('active')
            .siblings('.item')
            .removeClass('active');
        $('home').append("<adminHome></adminHome>") ;
        riot.mount('adminHome');
        this.isAdminPresent = true ;
        this.isModifyPresent = false ;
	this.isAddPresent = false ;
    }

    //mounting "modifyHome"
    mountModify(){
        if( this.isModifyPresent ){
            return ;
        }
	    $('adminHome').detach();
        $('addHome').detach() ;
        $('#modifyF').addClass('active')
            .siblings('.item')
            .removeClass('active');
        $('home').append("<modifyHome></modifyHome>") ;
        riot.mount('modifyHome');
        this.isAdminPresent = false ;
        this.isAddPresent = false ;
        this.isModifyPresent = true ;
    }
    </script>
</home>
