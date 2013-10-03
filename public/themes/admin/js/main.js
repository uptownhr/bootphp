$(document).ready(function(){
    
    // Bootstrap hashes for tabs
    var hash = window.location.hash;
    hash && $('ul.nav a[href="' + hash + '"]').tab('show');

    $('.nav-tabs a').click(function (e) {
        $(this).tab('show');
        var scrollmem = $('body').scrollTop();
        window.location.hash = this.hash;
        $('html,body').scrollTop(scrollmem);
    });

    // Initialize tooltips
    $('.ttip').tooltip();

    // Add a select menu for each TH element in the table footer
    //$("tr.advanced-search").each( function () {
    //    table = $(this).parent().parent().dataTable();
    //
    //    $(this).find('th').each(function(i){
    //        this.innerHTML = fnCreateSelect(table.fnGetColumnData(i));
    //        $('select', this).change(function () {
    //            table.fnFilter($(this).val(), i);
    //        }); 
    //    });
    //});

    // Initalize select2 boxes
    $(".select2").select2({
        allowClear: true
    });

    // Advanced search toggle
    $('.btn-advanced-search').click(function(e){
        e.preventDefault();
        $(this).parent().parent().parent().find('tr.advanced-search').toggleClass('open').find('.col-remove').html('<button class="btn btn-default btn-xs"><span class="icon-remove"></span></button>');
        $(this).find('span').toggleClass('icon-caret-down').toggleClass('icon-caret-up');
    });
    
    // Advanced search toggle
    $('.datatable').on('click', 'tr.advanced-search .col-ignore .btn', function(){
        $(this).parent().parent().parent().parent().parent().find('.btn-advanced-search span').addClass('icon-caret-down').removeClass('icon-caret-up');
        $(this).parent().parent().toggleClass('open').find('.col-remove').html('');
    });

    // Initialize all date and time pickers
    $('.input-date').datepicker({ dateFormat: 'yy-mm-dd' });
    $('.input-time').timepicker({ 'appendTo': '#header-btns'});

    if ($('body').has('.DTTT_container').length) {
        $('#header-btns .inner > :last-child').after('&nbsp;');
        $('.DTTT_container').insertAfter('#header-btns .inner > :last-child');
    }
    

    // Initialize tree views
    $(".treeview").treeview({
        persist: "location",
        collapsed: true,
        unique: false,
        animated: "medium"
    });

    // Prevent show/hide dropdown from disappearing after first option is toggled
    $('.show-hide .dropdown-menu li').on("click", function(e){
        if (!$(this).hasClass('close-dropdown')) {
            e.stopPropagation();
        }
    });

    // Files tabs: Add additional uploads button
    $('#new-upload').click(function(e){
        e.preventDefault();
        $('#input-files').append('<input type="text" name="file_labels[]" class="form-control" placeholder="Description"><input type="file" name="file_uploads[]" class="input-small input-file"><br><br>');
    });


    // Check all / Uncheck all
    $('th input[type="checkbox"]').on('click', function(e){
        if ($(this).prop('checked')) {
            $(this).closest('table').find('input[type="checkbox"]').prop('checked', this.checked);
            $(this).closest('table').find('tr').addClass('highlight');
        } else {
            $(this).closest('table').find('input[type="checkbox"]').prop('checked', this.checked);
            $(this).closest('table').find('tr').removeClass('highlight');
        }
    });
    
    // Check / Uncheck single row
    $('td.col-checkbox input[type="checkbox"]').on('click', function(e){
        if ($(this).prop('checked')) {
            $(this).closest('tr').addClass('highlight');
        } else {
            $(this).closest('tr').removeClass('highlight');
        }
    });

    // Expand / Collapse all
    $('.expand-collapse-all').click(function(e){
        e.preventDefault();
        if ($(this).html() == '<span class="icon icon-plus-sign"></span> Expand All') {
            $(this).html('<span class="icon icon-minus-sign"></span> Collapse All');
            $('.details').addClass('show');
            $('.expand-row').find('.icon').addClass('icon-minus-sign').removeClass('icon-plus-sign');
        } else {
            $(this).html('<span class="icon icon-plus-sign"></span> Expand All');
            $('.details').removeClass('show');
            $('.expand-row').find('.icon').removeClass('icon-minus-sign').addClass('icon-plus-sign');
        }
    });

    if ($(document).scrollTop() > 0 && !$('#header-btns').hasClass('fixed')) {
        $('#header-btns').hide().addClass('fixed').fadeIn('fast');
    }

    // Sticky upper right buttons
    $(document).scroll(function(){
        if (!$('#header-btns .inner').is(':empty')) {
            if ($(document).scrollTop() > 0 && !$('#header-btns').hasClass('fixed')) {
                $('#header-btns').hide().addClass('fixed').fadeIn('fast');
            } else if (!$('#header-btns').hasClass('fixed') || !$(document).scrollTop() > 0) {
                $('#header-btns').removeClass('fixed');
            }
        }
    });
    
    // Slide up effect when deleting a row
    //$('.table').on('click', '.btn-delete', function(e){
    //    $thisrow = $(this).parent().parent();
    //    $('<div></div>').appendTo('body')
    //    .html('<p><span class="icon-warning-sign"></span> Action cannot be undone.</p>')
    //    .dialog({
    //        modal: true, title: 'Really delete item?', zIndex: 10000, autoOpen: true,
    //        width: 'auto', resizable: false,
    //        buttons: {
    //            Yes: function () {
    //                $(this).dialog("close");
    //                $thisrow.find('td').each(function(){
    //                    $(this).wrapInner('<div style="overflow:hidden"></div>').find('div').animate({ height: 0 }, 250, function(){
    //                        $(this).parent().animate({ padding: 0 }, 50);
    //                    });
    //                });
    //                setTimeout(function(){ $thisrow.remove(); }, 300);
    //            },
    //            No: function () {
    //                $(this).dialog("close");
    //            }
    //        }
    //    });
    //});
    
    if ($('.table-search input').val() != '') {
        $('.table-search').append('<abbr class="select2-search-choice-close"></abbr>');
    }
    
    // Append X to clear search field
    $('.table-search').on('keyup', 'input', function(){
        if ($(this).val() != '' && $(this).parent().has('abbr').length == 0) {
            $(this).after('<abbr class="select2-search-choice-close"></abbr>');
        }
        if ($(this).val() == '') {
            $(this).parent().find('abbr').remove();
        }
    });
    
    // X clears search field
    $('.table-search').on('click', 'abbr', function(){
        // find the datatables object and clear filter
        $(this).parent().parent().parent().find('.datatable').dataTable().fnFilter('');
        $(this).remove();
    });
    
    //Files stuff
    $('.tab-pane table input[type="checkbox"]').on('click', function(){
        if ($(this).prop("checked")) {
            $(this).closest('.tab-pane').find('.checked-filter').removeClass('hide');
        } else {
            $(this).closest('.tab-pane').find('.checked-filter').addClass('hide');
        }
    });
    
    // tinyMCE initialization
    tinymce.init({
        selector: ".input-note",
        //toolbar: "undo redo | copy paste | bold italic underline strikethrough | alignleft aligncenter alignright | indent outdent | bullist numlist | link image hr",
        toolbar: "undo redo | copy paste | bold italic underline strikethrough | bullist numlist | link image hr",
        menubar: false,
        width: 600,
        height: 180,
        plugins: "link,image,lists",
        statusbar: false,
        content_css: "/css/tinymce.css"
    });
    
    
    $('#header-btns .save').click(function(){
        $.post("/admin/data", $('.main-form').serialize(), function(res) {
            if (res.status.code == 200) {
                $('.name-display').text($('input[name="name"]').val());
                $('.company-display').text($('input[name="company"]').val());
                $.bootstrapGrowl('<span class="icon-ok-sign"></span> Saved', { type: 'success' });
                if (!$('body').find('.id-display').length && $('body').hasClass('single')) {
                    var ids = ['account_id', 'bank_id', 'corporation_id', 'mid_id', 'agent_id'], result, path;
                    for (var i=0; i < ids.length; i++) {
                        var variable = 'res.result.'+ ids[i];
                        var temp = eval(variable);
                        if (temp != undefined) {
                            result = variable;
                            path = ids[i].replace("_id","");
                        }
                    }
                    window.location = '/admin/' + path + '/id/' + eval(result);
                }
            } else {
                $.bootstrapGrowl('<span class="icon-warning-sign"></span> Error saving: ' + res.status.code, { type: 'danger' });
            }
        });
        
        $('table.sites tbody tr').each(function(){
            var id = $(this).attr('data-site-id');
            var paysite = $(this).find('input[name="paysite"]').val();
            var username = $(this).find('input[name="username"]').val();
            var password = $(this).find('input[name="password"]').val();
            var int_descriptor1 = $(this).find('input[name="int_descriptor1"]').val();
            var int_descriptor2 = $(this).find('input[name="int_descriptor2"]').val();
            var data = 'model=Accountsite&paysite=' + paysite;
            data += '&account_id=' + $('input[name="id"]').val();
            data += '&paysite=' + paysite;
            data += '&username=' + username;
            data += '&password=' + password;
            data += '&int_descriptor1=' + int_descriptor1;
            data += '&int_descriptor2=' + int_descriptor2;
            if (id!=undefined) {
                data += '&id=' + id;
            }
            if (paysite != '') {
                $.post("/admin/data", data, function(res) {
                
                });
            }
        });
    
    });
    

    // Delete single record and all associated notes, sites    
    $('#header-btns .delete').click(function(){
        $('<div></div>').appendTo('body')
        .html('<p><span class="icon-warning-sign"></span> Action cannot be undone.</p>')
        .dialog({
            modal: true, title: 'Really delete item?', zIndex: 10000, autoOpen: true,
            width: 'auto', resizable: false,
            buttons: {
                Yes: function () {
                    var model = $('input[name="model"]').val();
                    var id = $('input[name="id"]').val();
                    var data = 'cmd=delete&model=' + model + '&id=' + id;
                    var errors = false;
                    
                    // Delete main record
                    $.post("/admin/data", data, function(res) {
                        if (res.status.code != 200) {
                            errors = true;
                        }
                    });
                    
                    // Delete all notes
                    if (!$('table.notes tbody tr td.dataTables_empty').length) {
                        $('table.notes tbody tr').each(function(){
                            var id = $(this).attr('data-note-id').replace('note-','');
                            var data = "cmd=delete&model=Note&id=" + id;
                            $.post("/admin/data", data, function(res) {
                                if (res.status.code != 200) {
                                    errors = true;
                                }
                            });
                        });
                    }
                    
                    // Delete all sites
                    if (!$('table.sites tbody tr td.dataTables_empty').length) {
                        $('table.sites tbody tr').each(function(){
                            var id = $(this).attr('data-site-id');
                            var data = "cmd=delete&model=Accountsite&id=" + id;
                            $.post("/admin/data", data, function(res) {
                                if (res.status.code != 200) {
                                    errors = true;
                                }
                            });
                        });
                    }
                    if (errors == false) {
                        $.bootstrapGrowl('<span class="icon-ok-sign"></span> Record deleted', { type: 'success' });
                        setTimeout(function(){
                            window.location = '/admin/' + model.toLowerCase() + 's';
                        }, 2000);
                    } else {
                        $.bootstrapGrowl('<span class="icon-warning-sign"></span> Error saving: ' + res.status.code, { type: 'danger' });
                    }
                },
                No: function () {
                    $(this).dialog("close");
                }
            }
        });
    });
    
    //$('.input-rate, .input-fee').on('keyup', function(e) {
    //    $resultspan = $(this).parent().find('.result');
    //    
    //    var pass = true;
    //    $(this).parent().find('input').each(function(){
    //        if ($(this).val() == '') {
    //            pass = false;
    //        }
    //    });
    //    
    //    if (!$resultspan.has('.btn').length && pass == true) {
    //        $resultspan.prev('.icon-custom-equals:not(.volume)').addClass('show');
    //        $resultspan.hide().html('<button type="button" class="btn btn-primary btn-small">Calculate</button>').fadeIn('fast');
    //    } else if ($resultspan.has('.btn').length && pass == false) {
    //        $resultspan.prev('.icon-custom-equals:not(.volume)').removeClass('show');
    //        $resultspan.html('&nbsp;').hide();
    //    }
    //    //$resultspan.parent().find('.volume').removeClass('show');
    //});
    
    // Pre-populate MDR rate calculation
    //var mdr_rate = parseFloat($('input[name="mdr_rate"]').val());
    //var mdr_buyrate = parseFloat($('input[name="mdr_buyrate"]').val());
    //var mdr_coefficient = parseFloat($('input[name="mdr_coefficient"]').val());
    //if (!isNaN(mdr_rate) && !isNaN(mdr_buyrate) && !isNaN(mdr_coefficient)) {
    //    var result = (((mdr_rate/100) - (mdr_buyrate/100)) * (mdr_coefficient/100)) * 100;
    //    result = result.toFixed(3);
    //    $('#row-mdr').find('.icon-custom-equals:not(.volume)').addClass('show');
    //    $('#row-mdr').find('.result').html(result);
    //}
    //
    //$('#row-mdr').on('click', '.btn', function(e){
    //
    //    var mdr_rate = parseFloat($('input[name="mdr_rate"]').val());
    //    var mdr_buyrate = parseFloat($('input[name="mdr_buyrate"]').val());
    //    var mdr_coefficient = parseFloat($('input[name="mdr_coefficient"]').val());
    //    var pass = true;
    //    if (mdr_rate < 3.5) {
    //        alert('MDR rate must be greater than our buy rate!');
    //        pass = false;
    //    } else if (mdr_rate > 100 || mdr_coefficient > 100 || mdr_coefficient <= 0) {
    //        alert('Values should be between 0 and 100!');
    //        pass = false;
    //    } else if (isNaN(mdr_rate) || isNaN(mdr_buyrate) || isNaN(mdr_coefficient)) {
    //        alert('Fill out all three values!');
    //        pass = false;
    //    }
    //    if (pass == true){
    //        var result = (((mdr_rate/100) - (mdr_buyrate/100)) * (mdr_coefficient/100)) * 100;
    //        result = result.toFixed(3);
    //        $(this).parent().html(result);
    //    }
    //});
    
    // Pre-populate Transaction Fees
    //$('.row-fee').each(function(){
    //    // Pre-populate MDR rate calculation
    //    var fee = parseFloat($(this).find('.input-fee:eq(0)').val());
    //    var buyrate = parseFloat($(this).find('.input-fee:eq(1)').val());
    //    var coefficient = parseFloat($(this).find('.input-rate').val());
    //    if (!isNaN(fee) && !isNaN(buyrate) && !isNaN(coefficient)) {
    //        var result = (fee - buyrate) * (coefficient/100);
    //        result = result.toFixed(2);
    //        $(this).find('.result').html('$' + result);
    //        $(this).find('.icon-custom-equals').addClass('show');
    //    }
    //});
    //$('.row-fee').on('click', '.btn', function(e){
    //    var fee = parseFloat($(this).parent().parent().find('.input-fee:eq(0)').val());
    //    var buyrate = parseFloat($(this).parent().parent().find('.input-fee:eq(1)').val());
    //    var coefficient = parseFloat($(this).parent().parent().find('.input-rate').val());
    //    var pass = true;
    //    
    //    if (fee < 0) {
    //        alert('Fee cannot be negative!');
    //        pass = false;
    //    } else if (coefficient > 100 || coefficient <= 0) {
    //        alert('Coefficient value should be between 0 and 100!');
    //        pass = false;
    //    } else if ( $(this).parent().parent().hasClass('row-trans').length && (buyrate > 1 || buyrate <= 0) ) {
    //        alert('Buy rate should be between $0 and 1!');
    //        pass = false;
    //    }
    //    if (pass == true){
    //        var result = (fee - buyrate) * (coefficient/100);
    //        result = result.toFixed(2);
    //        $(this).parent().html('$' + result);
    //    }
    //});
    
    // Not Applicable should disable rate input
    $('.na').click(function(e){
        $parentrow = $(this).parent().parent().parent();
        if ($(this).prop('checked')) {
            $parentrow.find('input:not(.na)').prop('disabled', true);
            //$parentrow.find('.icon-custom-equals').removeClass('show');
            //$parentrow.find('.result').html('');
        } else {
            $parentrow.find('input:not(.na)').prop('disabled', false);
        }
    });
        
    var rates_html = '<div class="form-group" id="row-mdr"><label for="" class="col-lg-3 control-label">Merchant Discount Rate (MDR)</label><div class="col-lg-9"><input name="mdr_rate" class="input-small input-rate input-rate-percentage form-control" type="text">%</div></div><div class="form-group"><h4 class="col-lg-9 col-lg-offset-3">Transaction Fees</h4></div><div class="form-group row-fee row-trans"><label for="" class="col-lg-3 control-label">Successes</label><div class="col-lg-9 form-inline">$<input name="trans_success_fee" class="input-small input-fee input-dollars form-control" type="text"><div class="checkbox"> <label> <input name="trans_success_fee_na" class="na" type="checkbox"> N/A </label> </div></div></div><div class="form-group row-fee row-trans"><label for="" class="col-lg-3 control-label">Declines</label><div class="col-lg-9 form-inline">$<input name="trans_decline_fee" class="input-small input-fee input-dollars form-control" type="text"><div class="checkbox"> <label> <input name="trans_decline_fee_na" class="na" type="checkbox"> N/A </label> </div></div></div><div class="form-group row-fee row-trans"><label for="" class="col-lg-3 control-label">Authorizations</label><div class="col-lg-9 form-inline">$<input name="trans_auth_fee" class="input-small input-fee input-dollars form-control" type="text"><div class="checkbox"> <label> <input name="trans_auth_fee_na" class="na" type="checkbox"> N/A </label> </div></div></div><div class="form-group"> <h4 class="col-lg-3 col-lg-offset-3">Other Fees</h4> </div><div class="form-group row-fee"><label for="" class="col-lg-3 control-label">Chargeback Fee</label><div class="col-lg-9">$<input name="cb_fee" class="input-small input-fee input-dollars form-control" type="text"></div></div><div class="form-group row-fee"><label for="" class="col-lg-3 control-label">Refund Fee</label><div class="col-lg-9">$<input name="refund_fee" class="input-small input-fee input-dollars form-control" type="text"></div></div><div class="form-group row-fee"><label for="" class="col-lg-3 control-label">Void Fee</label><div class="col-lg-9">$<input name="void_fee" class="input-small input-fee input-dollars form-control" type="text"></div></div><div class="form-group row-fee"> <label for="" class="col-lg-3 control-label">Setup Fee</label><div class="col-lg-9">$<input name="setup_fee" class="input-small input-fee input-dollars form-control" type="text"></div></div><div class="form-group row-fee"> <label for="" class="col-lg-3 control-label">Monthly Fee</label><div class="col-lg-9">$<input name="monthly_fee" class="input-small input-fee input-dollars form-control" type="text"></div> </div>';
    
    $('.add-rates-dropdown button').click(function(){
        var curr = $('.add-rates-dropdown select').val();
        
        if (curr != '') {
            
            if ($('#tab-default-rates .nav').find('p').length) {
                $('#tab-default-rates .nav').html('');
            }
            
            var new_rates_html = rates_html;
        
            if (curr == 'gbp') {
                new_rates_html = new_rates_html.replace(new RegExp('\\$', 'g'), '&pound;');
            } else if (curr == 'eur') {
                new_rates_html = new_rates_html.replace(new RegExp('\\$', 'g'), '&euro;');
            } 
            
            new_rates_html = '<div id="tab-rates-' + curr + '" class="active tab-pane tab-rates">' + new_rates_html + '</div>';
            var menu_html = '<li class="active"><a href="#tab-rates-' + curr + '" data-toggle="tab">' + curr + ' <span class="icon-remove-sign"></span></a></li>';
            $('#tab-default-rates .nav li, #tab-default-rates .tab-pane').removeClass('active');
            $('#tab-default-rates .nav').append(menu_html);
            $('#tab-default-rates .tab-content').append(new_rates_html);
            
            $('.add-rates-dropdown select').val('');
            $('.add-rates-dropdown select option[value="' + curr + '"]').remove();
        }
    });
    
    $('#tab-default-rates').on('click', '.icon-remove-sign', function(){
        $this = $(this);
        var target = $this.parent().attr('href');
        var curr = target.replace('#tab-rates-', '');
        var title = 'Really delete ' + curr.toUpperCase() + ' rates?';
        $('<div></div>').appendTo('body')
        .html('<p><span class="icon-warning-sign"></span> Action cannot be undone.</p>')
        .dialog({
            modal: true, title: title, zIndex: 100000, autoOpen: true,
            width: 'auto', resizable: false,
            buttons: {
                Yes: function () {
                    $this.parent().parent().remove();
                    $(target).remove();
                    $('.add-rates-dropdown select').append('<option value="' + curr + '">' + curr.toUpperCase() + '</option>');
                    if ($('#tab-default-rates .nav').find('li').length == 0) {
                        $('#tab-default-rates .nav').html('<p>Add rates by selecting a currency.</p>');
                    } else {
                        $('#tab-default-rates .tab-content > div').removeClass('active');
                        $('#tab-default-rates .tab-content div:first-child').addClass('active');
                        $('#tab-default-rates .nav li:first-child').addClass('active');
                    }
                    $(this).dialog("close");
                },
                No: function () {
                    $(this).dialog("close");
                }
            }
        });
    });
    
    $('#tab-default-rates').on('click', '.na', function(){
        $(this).parent().parent().parent().toggleClass('disabled');
    });
    
    $('#tab-notes table').on('click', '.btn:not(.btn-delete)', function(e){
        var $row = $(this).closest('tr');
        var $cellnote = $(this).closest('tr').find('.cell-note');
        var $cell = $cellnote.closest('td');
        var rowIndex = $row.prevAll().length;
        var $this = $(this);
        var editor_id = $row.attr('data-note-id');
        
        if (!$(this).hasClass('cancel').length && !$(this).hasClass('save')) {    
            
            if ($row.find('.mce-tinymce').length == 0) {
                $(this).removeClass('btn-action').addClass('cancel').addClass('btn-sm').find('span').removeClass('icon-pencil').addClass('icon-remove').after(' Cancel');
                $cellnote.parent().parent().find('td:last-child').append('<button type="button" class="btn btn-primary btn-sm save"><span class="icon-download-alt"></span> Save</button>');
                $cell.append('<div class="original-note" style="display:none">' + $cellnote.html() + '</div>');
                
                tinymce.init({
                    selector: $cellnote.selector + ':eq(' + rowIndex + ')',
                    toolbar: "undo redo | copy paste | bold italic underline strikethrough | bullist numlist | link image hr",
                    menubar: false,
                    width: 600,
                    height: 140,
                    plugins: "link,image,lists",
                    statusbar: false,
                    content_css: "/css/tinymce.css",
                    extended_valid_elements: "p[style]",
                    inline_styles: true,
                    verify_html: false
                }); 
                
                $row.find('.btn-delete').hide();
                $row.find('.ttip').tooltip('destroy');
                
            } else {
                $(this).addClass('btn-action').removeClass('cancel').removeClass('btn-sm').attr('title','Edit').html('<span class="icon icon-pencil"></span>');
                var html = $cell.find('.original-note').html();
                tinymce.EditorManager.execCommand('mceRemoveControl',true, editor_id);
                $cell.html('<div class="cell-note">' + html + '</div>');
                $row.find('.save').remove();
                $row.find('.btn-delete').show();
                $row.find('.ttip').tooltip();
            }
        } else if ($(this).hasClass('save')) {
            $(this).parent().find('.btn-edit').addClass('btn-action').removeClass('cancel').removeClass('btn-sm').attr('title','Edit').html('<span class="icon icon-pencil"></span>');
            var editor_id = $row.attr('data-note-id');
            var html = tinymce.get(editor_id).getContent();
            tinymce.EditorManager.execCommand('mceRemoveControl', true, editor_id);
            $cell.html('<div class="cell-note" id="'+ editor_id +'">' + html + '</div>');
            $row.find('.save').remove();
            $row.find('.btn-delete').show();
            $row.find('.ttip').tooltip();
            
            var model_table = $('input[name="model"]').val();
            model_table = model_table.charAt(0).toUpperCase() + model_table.slice(1);
            var updater_id = $('input[name="user_id"]').val();
            var note_id = editor_id.replace('note-','');
            var data = 'model=Note&';
            data += 'note=' + html + '&';
            data += 'updater_id=' + updater_id + '&';
            data += 'note_id=' + note_id;
                
            $.post("/admin/data", data, function(res) {
                if (res.status.code == 200) {
                    tinyMCE.get('note-' + note_id).setContent('');
                    //var updated = 
                    var updater = $('input[name="username"]').val();
                    var modified = 'Just now<br><em>by ' + updater + '</em>';
                    $row.find('td:eq(3)').html(modified);
                    $.bootstrapGrowl('<span class="icon-ok-sign"></span> Note updated', { type: 'success' });
                } else {
                    $.bootstrapGrowl('<span class="icon-warning-sign"></span> Error updating: ' + res.status.code, { type: 'danger' });
                }
            });
        }
    });
    
    $('.btn-add-note').click(function(){
        
        if (!$('table.notes .mce-tinymce').length) {
            var note = tinyMCE.get('new-note').getContent();
            var model_table = $('input[name="model"]').val();
            model_table = model_table.charAt(0).toUpperCase() + model_table.slice(1);
            var linked_id = $('input[name="id"]').val();
            var creator_id = $('input[name="user_id"]').val();
            
            var data = 'model=Note&';
            data += 'note=' + note + '&';
            data += 'model_table=' + model_table + '&';
            data += 'linked_id=' + linked_id + '&';
            data += 'creator_id=' + creator_id;
                    
            $.post("/admin/data", data, function(res) {
                if (res.status.code == 200) {
                    tinyMCE.get('new-note').setContent('');
                    
                    var note_id = res.result.note_id;
                    
                    // Fabricated, ideally should use response data, but not for now
                    var created = 'Just now';
                    var creator = $('input[name="username"]').val();
                    
                    notesTable.fnAddData([
                        '<input type="checkbox">',
                        '<div class="cell-note" id="note-' + note_id + '">' + note + '</div>',
                        created + '<br><em>by ' + creator + '</em>',
                        'N/A',
                        '<button type="button" class="btn btn-primary btn-action btn-edit ttip" title="Edit"><span class="icon-pencil"></span></button> <button type="button" class="btn btn-danger btn-action btn-delete ttip" title="Delete"><span class="icon-trash"></span></button>'
                    ]);
                    
                    $('table.notes tr:last-child').attr('data-note-id', 'note-' + note_id);
                    
                    var row_count = $('table.notes tbody tr').length - $('table.notes tbody tr').has('td.dataTables_empty').length;
                    $('.nav-tabs li a[href="#tab-notes"] span.badge').text(row_count);
                    
                    $.bootstrapGrowl('<span class="icon-ok-sign"></span> Note added', { type: 'success' });
                    
                } else {
                    $.bootstrapGrowl('<span class="icon-warning-sign"></span> Error Saving: ' + res.status.code, { type: 'danger' });
                }
            });
        } else {
            alert("You must finish editing notes before adding a new one.");
        }
        
    });
    
    $('#tab-notes table').on('click', '.btn-delete', function(e){
        
        if (!$('table.notes .mce-tinymce').length) {
        
            var $row = $(this).closest('tr');
            var note_id = $row.attr('data-note-id');
            note_id = note_id.replace('note-','');
            var data = 'cmd=delete&model=Note&id=' + note_id;
            
            var index = $(this).closest('tbody').children().index($row);
        
            $('<div></div>').appendTo('body')
            .html('<p><span class="icon-warning-sign"></span> Action cannot be undone.</p>')
            .dialog({
                modal: true, title: 'Really delete note?', zIndex: 100000, autoOpen: true,
                width: 'auto', resizable: false,
                buttons: {
                    Yes: function () {
                        $.post("/admin/data", data, function(res) {
                            if (res.status.code == 200) {
                                var row_count = $('table.notes tbody tr').length - $('table.notes tbody tr').has('td.dataTables_empty').length;
                                $('.nav-tabs li a[href="#tab-notes"] span.badge').text(row_count);
                                $.bootstrapGrowl('<span class="icon-ok-sign"></span> Deleted', { type: 'success' });
                            } else {
                                $.bootstrapGrowl('<span class="icon-warning-sign"></span> Error deleting: ' + res.status.code, { type: 'danger' });
                            }
                        });
                        $(this).dialog("close");
                        notesTable.fnDeleteRow(index);
                    },
                    No: function () {
                        $(this).dialog("close");
                    }
                }
            });
        } else {
            alert("You must finish editing notes before deleting any.");
        }
    });
    
    $('.btn-add-site').click(function(e){
        var cell0 = '<td><input type="checkbox"></td>';
        var cell1 = '<input type="text" name="paysite" class="form-control input-sm">';
        var cell2 = '<input type="text" name="username" class="form-control input-sm">';
        var cell3 = '<input type="text" name="password" class="form-control input-sm">';
        var cell4 = '<input class="form-control input-sm" name="int_descriptor1" type="text">';
        var cell5 = '<input class="form-control input-sm" name="int_descriptor2" type="text">';
        var cell6 = '<button type="button" class="btn btn-danger btn-delete btn-sm"><span class="icon-trash"></span></button>';
        sitesTable.fnAddData([ cell0, cell1, cell2, cell3, cell4, cell5, cell6 ]);
        $('.ttip').tooltip();
    });
    
    $('table.sites').on('click', '.btn-delete', function(e){
                
        var $row = $(this).closest('tr');
        var site_id = $row.attr('data-site-id');
        var data = 'cmd=delete&model=Accountsite&id=' + site_id;
        
        var index = $(this).closest('tbody').children().index($row);
        
            
        $('<div></div>').appendTo('body')
        .html('<p><span class="icon-warning-sign"></span> Action cannot be undone.</p>')
        .dialog({
            modal: true, title: 'Really delete site?', zIndex: 100000, autoOpen: true,
            width: 'auto', resizable: false,
            buttons: {
                Yes: function () {
                    $.post("/admin/data", data, function(res) {
                        if (site_id != undefined) {
                            if (res.status.code == 200) {
                                var row_count = $('table.sites tbody tr').length - $('table.sites tbody tr').has('td.dataTables_empty').length;
                                $('.nav-tabs li a[href="#tab-sites"] span.badge').text(row_count);
                                $.bootstrapGrowl('<span class="icon-ok-sign"></span> Deleted', { type: 'success' });
                            } else {
                                $.bootstrapGrowl('<span class="icon-warning-sign"></span> Error deleting: ' + res.status.code, { type: 'danger' });
                            }
                        } else {
                            $.bootstrapGrowl('<span class="icon-ok-sign"></span> Deleted', { type: 'success' });
                        }
                    });
                    $(this).dialog("close");
                    sitesTable.fnDeleteRow(index);
                },
                No: function () {
                    $(this).dialog("close");
                }
            }
        });
    });
    
    $('.status-tracker input').click(function(){
        $(this).parent().parent().parent().toggleClass('completed')
        if ($(this).prop('checked')) {
            $(this).parent().parent().parent().next().removeClass('disabled').find('input').prop('disabled', false);
        } else {
            $(this).parent().parent().parent().nextAll().addClass('disabled').removeClass('completed').find('input').prop('checked', false).prop('disabled', true);
        }
    });
    
});

// Functions
function fnShowHide( iCol ) {
    // Get the DataTables object again - this is not a recreation, just a get of the object
    var oTable = $('.datatable').dataTable();
     
    var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
    oTable.fnSetColumnVis( iCol, bVis ? false : true );
}

function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}