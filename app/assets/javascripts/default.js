// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require template/library/jquery/jquery.min.js
//= require template/library/jquery/jquery-migrate.min.js
//= require template/library/bootstrap/js/bootstrap.js
//= #require template/library/bootstrap/bootstrap.min
//= #require template/library/bootstrap/js/bootstrap.min.js
//= require template/library/modernizr/modernizr.js
//= #require template/plugins/core_less-js/less.min.js

//= #require template/plugins/core_browser/ie/ie.prototype.polyfill.js
//= require template/plugins/forms_wizards/jquery.bootstrap.wizard
//= #require template/plugins/forms_elements_bootstrap-datepicker/js/bootstrap-datepicker
//= require template/plugins/forms_validator/jquery-validation/dist/jquery.validate.min

//= require template/plugins/notifications_notyfy/js/jquery.notyfy
//= #require template/components/admin_notifications_notyfy/notyfy.init

//= require template/plugins/notifications_gritter/js/jquery.gritter.min
//= #require template/components/admin_notifications_gritter/gritter.init

//= require template/ztree/jquery.ztree.all-3.5.min


//= require template/selectr/selectr
//= require template/summernote/summernote
//= require template/bootstrap3-dialog/bootstrap-dialog
//= require template/bootbox/purl
//= require template/ajaxloader/jquery-loader
//= #require template/plugins/forms_editors_wysihtml5/js/wysihtml5-0.3.0_rc2.min
//= #require template/plugins/forms_editors_wysihtml5/js/bootstrap-wysihtml5-0.0.2.js

//= require template/slidebar/slidebars.min
//= require jquery_ujs
//= require turbolinks
//= #require search
//= require highcharts
//= require exporting-highchart
//= require comments.js
//= require seemore.js
//= require work_experiences.js
//=require template/library/jquery-ui/js/jquery-ui.min
//=# require show_for_student
//= require_self
$.validator.setDefaults(
{
    showErrors: function(map, list)
    {
        this.currentElements.parents('label:first, div:first').find('.has-error').remove();
        this.currentElements.parents('.form-group:first').removeClass('has-error');
        this.currentElements.parent().removeClass('has-error');

        $.each(list, function(index, error)
        {
            var ee = $(error.element);
            var eep = ee.parents('label:first').length ? ee.parents('label:first') : ee.parents('div:first');
            //'.form-group:first'
            ee.parent().addClass('has-error');
            eep.find('.has-error').remove();
            eep.append('<p class="has-error help-block">' + error.message + '</p>');
        });
        //refreshScrollers();
    }
});

//$(".modal input:checkbox,.modal label").on("click", function(e)
//{
//    e.stopImmediatePropagation();
//    var element = (e.currentTaget.htmlFor !== undefined) ? e.currentTaget.htmlFor : e.currentTaget;
//    var checked = (element.checked) ? false : true;
//    element.checked = (checked) ? false : checked.toString();
//});

$.validator.addMethod("custom_email", function (value, element) {
    return this.optional(element) || /^\s*(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\s*$/.test(value);
}, "Please enter a valid email address");

$.validator.addMethod("alphanumeric", function(value, element) {
    return this.optional(element) || /^\s*[^(~`!@#$%^&*()-+\\[\]\{\}=,?\/:;'"|><)]*\s*$/i.test(value);
}, "Letters, numbers, and underscores only please");

$.validator.addMethod("now_year", function (value, element) {
    now = new Date();
    year = now.getUTCFullYear();
    return year < value;
}, "Please enter a valid year");

$.validator.addMethod("less", function(value, element, param) {
    return this.optional(element) || value < $(param).val();
}, "less");

$.validator.addMethod("less_or_equals", function(value, element, param) {
    return this.optional(element) || value <= $(param).val();
}, "less_or_equals");

$.validator.addMethod("greater", function(value, element, param) {
    return this.optional(element) || value > $(param).val();
}, "greater");

$.validator.addMethod("greater_or_equals", function(value, element, param) {
    console.log(value);
    console.log($(param).val());
    return this.optional(element) || value >= $(param).val();
}, "greater_or_equals");
