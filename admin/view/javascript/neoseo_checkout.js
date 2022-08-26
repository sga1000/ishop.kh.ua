$(document).ready(function() {
    $('.ui-sortable').sortable({
        placeholder: 'empty',
        handle: '.handler',
        revert: 150,
        start: function (event, ui) { ui.item.addClass('start'); $('.empty').height($('.ui-sortable li:first').height()); },
        stop: function (event, ui) { ui.item.removeClass('start'); }
    });

	// Tooltip
	$('.tooltip-trigger').hover(function(){
		var title = $(this).attr('title');
		$(this).data('tooltipText', title).removeAttr('title');
		
		$('<p class="tooltip"></p>').html(title).appendTo('body').fadeIn('slow');
	}, function() {
		$(this).attr('title', $(this).data('tooltipText'));
		
		$('.tooltip').remove();
	}).mousemove(function(e) {
		var mousex = e.pageX - 220;
		var mousey = e.pageY + 5;
		
		$('.tooltip').css({ top: mousey, left: mousex })
	});

    $('.ui-sortable .edit').click(function(e){
        e.preventDefault();
        var target = $(this).attr('toggle');
        $("#" + target).toggle();
    });

    $('.ui-sortable .delete').click(function(e){
        e.preventDefault();
        var target = $(this).parent().parent().attr('id');
        $("#" + target).remove();
    });

    $('#tab-customer .add-field').click(function(e){
        e.preventDefault();


        var type = $('[name=customer_group]:checked').val();
        var fieldList = "#tab-customer ul.type-" + type;
        var i = parseInt($(fieldList).attr("data-count")) + 1;
        $(fieldList).append('<li id="customer_field_' + type + '_' + i + '"></li>');
        setFieldData("#customer_field_" + type + "_" + i,{
            i: type + "_" + i,
            table_prefix: 'neoseo_checkout_customer_fields',
            html_field: 'neoseo_checkout_customer_fields[' + type + '][' + i + ']',
            label: { 1: 'Поле №' + i},
            field: 'custom',
            type: 'input',
            name: 'custom_' + i,
            mask: '',
            initial: '',
            only_register: 0,
            display: 1,
            required: 0
        });

        $('#customer_field_' + type + '_' + i + ' .edit').click(function(e){
            e.preventDefault();
            var target = $(this).attr('toggle');
            $("#" + target).toggle();
        });

        $('#customer_field_' + type + '_' + i + ' .delete').click(function(e){
            e.preventDefault();
            var target = $(this).parent().parent().attr('id');
            $("#" + target).remove();
        });

        $(fieldList).attr("data-count",i);
        $('#customer_field_' + type + '_' + i + '.select_field_name').trigger("change");
    });

    $('#payment_methods').change(function(){
        var payment = $(this).val();

        $("#tab-payment .payment_fields").css("display","none");
        $("#payment_fields_" + payment.replace(/\./g,"_")).css("display","inline");
    });

    $('#tab-payment .add-field').click(function(e){
        e.preventDefault();
        var payment = $("#payment_methods").val();

        var i = parseInt($("#payment_fields_" + payment.replace(/\./g,"_")).attr("data-count")) + 1;

        $( "#payment_fields_" + payment.replace(/\./g,"_") ).append('<li id="payment_field_' + payment.replace(/\./g,"_") + "_" + i + '"></li>');

        setFieldData("#payment_field_" + payment.replace(/\./g,"_") + "_" + i, {
            i: i,
            html_field: 'neoseo_checkout_payment_fields[' + payment +'][' + i + ']',
            table_prefix: 'neoseo_checkout_payment_fields_' + payment.replace(/\./g,"_"),
            label: { 1: 'Поле №' + i},
            field: 'custom',
            type: 'input',
            name: 'custom_' + i,
            mask: '',
            initial: '',
            display: 1,
            required: 0
        });

        $("#payment_field_" + payment.replace(/\./g,"_") + "_" + i + ' .edit').click(function(e){
            e.preventDefault();
            var target = $(this).attr('toggle');
            $("#" + target).toggle();
        });

        $("#payment_field_" + payment.replace(/\./g,"_") + "_" + i + ' .delete').click(function(e){
            e.preventDefault();
            var target = $(this).parent().parent().attr('id');
            $("#" + target).remove();
        });

        $("#payment_fields_" + payment.replace(/\./g,"_") ).attr("data-count",i);
        $('#payment_field_' + payment.replace(/\./g,"_") + '_' + i + '.select_field_name').trigger("change");
    });

    $('#shipping_methods').change(function(){
        var shipping = $(this).val();

        $("#tab-shipping .shipping_fields").css("display","none");
        $("#shipping_fields_" + shipping.replace(/\./g,"_")).css("display","inline");
    });

    $('#tab-shipping .add-field').click(function(e){
        e.preventDefault();
        var shipping = $("#shipping_methods").val();

        var i = parseInt($("#shipping_fields_" + shipping.replace(/\./g,"_")).attr("data-count")) + 1;

        $( "#shipping_fields_" + shipping.replace(/\./g,"_") ).append('<li id="shipping_field_' + shipping.replace(/\./g,"_") + "_" + i + '"></li>');

        setFieldData("#shipping_field_" + shipping.replace(/\./g,"_") + "_" + i, {
            i: i,
            html_field: 'neoseo_checkout_shipping_fields[' + shipping +'][' + i + ']',
            table_prefix: 'neoseo_checkout_shipping_fields_' + shipping.replace(/\./g,"_"),
            label: { 1: 'Поле №' + i},
            field: 'custom',
            type: 'input',
            name: 'custom_' + i,
            mask: '',
            initial: '',
            display: 1,
            required: 0
        });

        $("#shipping_field_" + shipping.replace(/\./g,"_") + "_" + i + ' .edit').click(function(e){
            e.preventDefault();
            var target = $(this).attr('toggle');
            $("#" + target).toggle();
        });

        $("#shipping_field_" + shipping.replace(/\./g,"_") + "_" + i + ' .delete').click(function(e){
            e.preventDefault();
            var target = $(this).parent().parent().attr('id');
            $("#" + target).remove();
        });

        $("#shipping_fields_" + shipping.replace(/\./g,"_") ).attr("data-count",i);
        $('#shipping_field_' + shipping.replace(/\./g,"_") + '_' + i + '.select_field_name').trigger("change");
    });
});

function setFieldData(selector,field){
    $(selector).html(
            $('#fieldTmpl').render([field])
    );
    $("#" + field.table_prefix + "_field_" + field.i + "_field").val(field.field);
    $("#" + field.table_prefix + "_field_" + field.i + "_type").val(field.type);
    $("#" + field.table_prefix + "_field_" + field.i + "_display").val(field.display);
	$("#" + field.table_prefix + "_field_" + field.i + "_only_register").val(field.only_register);
    $("#" + field.table_prefix + "_field_" + field.i + "_required").val(field.required);
}