<?php echo $header; ?>
<style>
#footer {margin-top:0px;}
.list .help {
    max-width: 300px;
}
</style>
<script type="text/javascript" src="view/javascript/jquery/ui/i18n/jquery.ui.datepicker-<?php echo $current_language ?>.js"></script>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
  </div>
  <div class="content">
    <div id="tabs" class="htabs">
        <a href="#tab-checkout"><?php echo $tab_checkout; ?></a>
        <a href="#tab-registration"><?php echo $tab_registration; ?></a>
        <a href="#tab-customer-fields"><?php echo $tab_customer_fields; ?></a>
        <a href="#tab-company-fields"><?php echo $tab_company_fields; ?></a>
        <a href="#tab-aceshop">AceShop</a>
    </div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <div id="tab-checkout">
        <h3><?php echo $text_simplecheckout ?></h3>
        <table class="form">
          <tr>
            <td>
                <span class="required">*</span> <?php echo $entry_template; ?>
                <span class="help"><?php echo $entry_template_description; ?></span>
            </td>
            <td><textarea name="simple_common_template" cols="150" rows="5"><?php echo $simple_common_template ?></textarea>
              <?php if (isset($error_simple_common_template)) { ?>
              <span class="error"><?php echo $error_simple_common_template ?></span>
              <?php } ?>
                <div class="help">Examples:</div>
                <br>
                <div class="help">Two columns:</div>
                <div class="help">{left_column}{cart}{customer}{/left_column}{right_column}{shipping}{payment}{help}{agreement}{/right_column}{payment_form}</div>
                <br>
                <div class="help">One column:</div>
                <div class="help">{help}{customer}{shipping}{payment}{cart}{agreement}{payment_form}</div>
                <br>
                <div class="help">Combined:</div>
                <div class="help">{help}{customer}{left_column}{shipping}{/left_column}{right_column}{payment}{/right_column}{cart}{agreement}{payment_form}</div>
            </td>  
          </tr>
          <tr>
            <td>
                Debug mode:
            </td>
            <td>
                <label><input type="radio" name="simple_debug" value="1" <?php if ($simple_debug) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_debug" value="0" <?php if (!$simple_debug) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_guest_checkout ?>:
            </td>
            <td>
                <label><input type="radio" name="simple_disable_guest_checkout" value="1" <?php if ($simple_disable_guest_checkout) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_disable_guest_checkout" value="0" <?php if (!$simple_disable_guest_checkout) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_empty_email ?>:
            </td>
            <td>
                <input type="text" name="simple_empty_email" value="<?php echo $simple_empty_email ?>">
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_fields_for_reload; ?>
            </td>
            <td>
                <div id="msc_simple_fields_for_reload"></div>
                <input type="hidden" name="simple_fields_for_reload" id="simple_fields_for_reload_input" value="<?php echo isset($simple_fields_for_reload) ? $simple_fields_for_reload : "" ?>" />
                <select style="margin-top:5px;" id="simple_fields_for_reload">
                <option value=""><?php echo $text_select ?></option>
                <?php foreach ($simple_customer_all_fields_settings as $key => $settings) { ?>
                <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                <?php } ?>
                </select>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_use_cookies; ?>:
            </td>
            <td>
                <label><input type="radio" name="simple_use_cookies" value="1" <?php if ($simple_use_cookies) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_use_cookies" value="0" <?php if (!$simple_use_cookies) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
            </td>
          </tr>
        </table>
        <h3><?php echo $text_order_minmax ?></h3>
        <table class="form">
          <tr>
            <td>
                <?php echo $entry_use_total; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_use_total" value="1" <?php if ($simple_use_total) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_use_total" value="0" <?php if (!$simple_use_total) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_show_weight; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_show_weight" value="1" <?php if ($simple_show_weight) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_show_weight" value="0" <?php if (!$simple_show_weight) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_min_amount; ?>
            </td>
            <td>
                <input type="text" name="simple_min_amount" value="<?php echo $simple_min_amount ?>">
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_max_amount; ?>
            </td>
            <td>
                <input type="text" name="simple_max_amount" value="<?php echo $simple_max_amount ?>">
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_min_quantity; ?>
            </td>
            <td>
                <input type="text" name="simple_min_quantity" value="<?php echo $simple_min_quantity ?>">
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_max_quantity; ?>
            </td>
            <td>
                <input type="text" name="simple_max_quantity" value="<?php echo $simple_max_quantity ?>">
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_min_weight; ?>
            </td>
            <td>
                <input type="text" name="simple_min_weight" value="<?php echo $simple_min_weight ?>">
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_max_weight; ?>
            </td>
            <td>
                <input type="text" name="simple_max_weight" value="<?php echo $simple_max_weight ?>">
            </td>
          </tr>
        </table>
        <h3><?php echo $text_agreement_block ?></h3>
        <table class="form">
          <tr>
            <td>
                <?php echo $entry_agreement_id; ?>
            </td>
            <td>
                <select name="simple_common_view_agreement_id">
                    <option value="0"><?php echo $text_select ?></option>
                    <?php foreach ($informations as $information) { ?>
                    <option value="<?php echo $information['information_id'] ?>" <?php if ($information['information_id'] == $simple_common_view_agreement_id) { ?>selected="selected"<?php } ?>><?php echo $information['title'] ?></option>
                    <?php } ?>
                </select>
              <?php if (isset($error_simple_common_view_agreement_id)) { ?>
              <span class="error"><?php echo $error_simple_common_view_agreement_id ?></span>
              <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_agreement_text; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_common_view_agreement_text" value="1" <?php if ($simple_common_view_agreement_text) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_common_view_agreement_text" value="0" <?php if (!$simple_common_view_agreement_text) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_common_view_agreement_text)) { ?>
                <span class="error"><?php echo $error_simple_common_view_agreement_text ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_agreement_checkbox; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_common_view_agreement_checkbox" value="1" <?php if ($simple_common_view_agreement_checkbox) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_common_view_agreement_checkbox" value="0" <?php if (!$simple_common_view_agreement_checkbox) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_common_view_agreement_checkbox)) { ?>
                <span class="error"><?php echo $error_simple_common_view_agreement_checkbox ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_agreement_checkbox_init; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_common_view_agreement_checkbox_init" value="1" <?php if ($simple_common_view_agreement_checkbox_init) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_common_view_agreement_checkbox_init" value="0" <?php if (!$simple_common_view_agreement_checkbox_init) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_common_view_agreement_checkbox_init)) { ?>
                <span class="error"><?php echo $error_simple_common_view_agreement_checkbox_init ?></span>
                <?php } ?>
            </td>  
          </tr>
        </table>
        <h3><?php echo $text_help_block ?></h3>
        <table class="form">
          <tr>
            <td>
                <?php echo $entry_help_id; ?>
            </td>
            <td>
                <select name="simple_common_view_help_id">
                    <option value="0"><?php echo $text_select ?></option>
                    <?php foreach ($informations as $information) { ?>
                    <option value="<?php echo $information['information_id'] ?>" <?php if ($information['information_id'] == $simple_common_view_help_id) { ?>selected="selected"<?php } ?>><?php echo $information['title'] ?></option>
                    <?php } ?>
                </select>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_help_text; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_common_view_help_text" value="1" <?php if ($simple_common_view_help_text) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_common_view_help_text" value="0" <?php if (!$simple_common_view_help_text) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
            </td>  
          </tr>
        </table>
        <h3><?php echo $text_shipping_block ?></h3>
        <table class="form">
          <tr>
            <td>
                <?php echo $entry_hide; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_shipping_methods_hide" value="1" <?php if ($simple_shipping_methods_hide) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_shipping_methods_hide" value="0" <?php if (!$simple_shipping_methods_hide) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_shipping_methods_hide)) { ?>
                <span class="error"><?php echo $error_simple_shipping_methods_hide ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_shipping_title; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_shipping_view_title" value="1" <?php if ($simple_shipping_view_title) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_shipping_view_title" value="0" <?php if (!$simple_shipping_view_title) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_shipping_view_title)) { ?>
                <span class="error"><?php echo $error_simple_shipping_view_title ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_shipping_address_empty; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_shipping_view_address_empty" value="1" <?php if ($simple_shipping_view_address_empty) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_shipping_view_address_empty" value="0" <?php if (!$simple_shipping_view_address_empty) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_shipping_view_address_empty)) { ?>
                <span class="error"><?php echo $error_simple_shipping_view_address_empty ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_shipping_autoselect_first; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_shipping_view_autoselect_first" value="1" <?php if ($simple_shipping_view_autoselect_first) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_shipping_view_autoselect_first" value="0" <?php if (!$simple_shipping_view_autoselect_first) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_shipping_view_autoselect_first)) { ?>
                <span class="error"><?php echo $error_simple_shipping_view_autoselect_first ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_shipping_address_full; ?>
                <span class="help"><?php echo $entry_shipping_address_full_description; ?></span>
            </td>
            <td>
                <table>
                    <?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
                    <tr>
                        <td>
                        <?php echo $shipping_name ?>
                        </td>
                        <td>
                            <label><input type="radio" name="simple_shipping_view_address_full[<?php echo $shipping_code ?>]" value="1" <?php if (!empty($simple_shipping_view_address_full[$shipping_code])) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                            <label><input type="radio" name="simple_shipping_view_address_full[<?php echo $shipping_code ?>]" value="0" <?php if (empty($simple_shipping_view_address_full[$shipping_code])) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                        </td>
                    </tr>
                    <?php } ?>
                </table>
            </td>  
          </tr>
        </table>
        <h3><?php echo $text_payment_block ?></h3>
        <table class="form">
          <tr>
            <td>
                <?php echo $entry_hide; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_payment_methods_hide" value="1" <?php if ($simple_payment_methods_hide) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_payment_methods_hide" value="0" <?php if (!$simple_payment_methods_hide) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_shipping_methods_hide)) { ?>
                <span class="error"><?php echo $error_simple_shipping_methods_hide ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_payment_address_empty; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_payment_view_address_empty" value="1" <?php if ($simple_payment_view_address_empty) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_payment_view_address_empty" value="0" <?php if (!$simple_payment_view_address_empty) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_payment_view_address_empty)) { ?>
                <span class="error"><?php echo $error_simple_payment_view_address_empty ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_payment_autoselect_first; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_payment_view_autoselect_first" value="1" <?php if ($simple_payment_view_autoselect_first) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_payment_view_autoselect_first" value="0" <?php if (!$simple_payment_view_autoselect_first) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_payment_view_autoselect_first)) { ?>
                <span class="error"><?php echo $error_simple_payment_view_autoselect_first ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_payment_address_full; ?>
                <span class="help"><?php echo $entry_payment_address_full_description; ?></span>
            </td>
            <td>
                <table>
                    <?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
                    <tr>
                        <td>
                        <?php echo $payment_name ?>
                        </td>
                        <td>
                            <label><input type="radio" name="simple_payment_view_address_full[<?php echo $payment_code ?>]" value="1" <?php if (!empty($simple_payment_view_address_full[$payment_code])) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                            <label><input type="radio" name="simple_payment_view_address_full[<?php echo $payment_code ?>]" value="0" <?php if (empty($simple_payment_view_address_full[$payment_code])) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                        </td>
                    </tr>
                    <?php } ?>
                </table>
            </td>  
          </tr>
        </table>
        <h3><?php echo $text_customer_block ?></h3>
        <table class="form">
          <tr>
            <td>
                <?php echo $entry_hide_if_logged; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_hide_if_logged" value="1" <?php if ($simple_customer_hide_if_logged) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_hide_if_logged" value="0" <?php if (!$simple_customer_hide_if_logged) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_hide_if_logged)) { ?>
                <span class="error"><?php echo $error_simple_customer_hide_if_logged ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_show_will_be_registerd; ?>:
            </td>
            <td>
                <label><input type="radio" name="simple_show_will_be_registered" value="1" <?php if ($simple_show_will_be_registered) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_show_will_be_registered" value="0" <?php if (!$simple_show_will_be_registered) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
            </td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_customer_register; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_action_register" value="1" <?php if ($simple_customer_action_register == 1) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_action_register" value="0" <?php if (!$simple_customer_action_register) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <label><input type="radio" name="simple_customer_action_register" value="2" <?php if ($simple_customer_action_register == 2) { ?>checked="checked"<?php } ?>><?php echo $text_user_choice ?></label>
                <?php if (isset($error_simple_customer_action_register)) { ?>
                <span class="error"><?php echo $error_simple_customer_action_register ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr id="customer_view_email" <?php if ($simple_customer_action_register == 1) { ?>style="display:none"<?php } ?>>
            <td>
                <?php echo $entry_customer_email_field; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_view_email" value="0" <?php if ($simple_customer_view_email == 0) { ?>checked="checked"<?php } ?>><?php echo $text_hide ?></label>
                <label><input type="radio" name="simple_customer_view_email" value="1" <?php if ($simple_customer_view_email == 1) { ?>checked="checked"<?php } ?>><?php echo $text_show_not_required ?></label>
                <label><input type="radio" name="simple_customer_view_email" value="2" <?php if ($simple_customer_view_email == 2) { ?>checked="checked"<?php } ?>><?php echo $text_required ?></label>
                <?php if (isset($error_simple_customer_view_email)) { ?>
                <span class="error"><?php echo $error_simple_customer_view_email ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr id="customer_register_init" <?php if ($simple_customer_action_register != 2) { ?>style="display:none"<?php } ?>>
            <td>
                <?php echo $entry_customer_register_init; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_view_customer_register_init" value="1" <?php if ($simple_customer_view_customer_register_init) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_view_customer_register_init" value="0" <?php if (!$simple_customer_view_customer_register_init) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_view_customer_register_init)) { ?>
                <span class="error"><?php echo $error_simple_customer_view_customer_register_init ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr id="customer_password_generate" <?php if ($simple_customer_action_register == 0) { ?>style="display:none"<?php } ?>>
            <td>
                <?php echo $entry_generate_password; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_generate_password" value="1" <?php if ($simple_customer_generate_password) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_generate_password" value="0" <?php if (!$simple_customer_generate_password) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_generate_password)) { ?>
                <span class="error"><?php echo $error_simple_customer_generate_password ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr id="customer_password_confirm" <?php if ($simple_customer_action_register == 0) { ?>style="display:none"<?php } ?>>
            <td>
                <?php echo $entry_customer_password_confirm; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_view_password_confirm" value="1" <?php if ($simple_customer_view_password_confirm) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_view_password_confirm" value="0" <?php if (!$simple_customer_view_password_confirm) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_view_password_confirm)) { ?>
                <span class="error"><?php echo $error_simple_customer_view_password_confirm ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr id="customer_password_length" <?php if ($simple_customer_action_register == 0) { ?>style="display:none"<?php } ?>>
            <td>
                <?php echo $entry_password_length; ?>
            </td>
            <td>
                min <input type="text" size="3" name="simple_customer_view_password_length_min" value="<?php echo $simple_customer_view_password_length_min ?>" >
                max <input type="text" size="3" name="simple_customer_view_password_length_max" value="<?php echo $simple_customer_view_password_length_max ?>" >
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_customer_subscribe; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_action_subscribe" value="1" <?php if ($simple_customer_action_subscribe == 1) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_action_subscribe" value="0" <?php if (!$simple_customer_action_subscribe) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <label><input type="radio" name="simple_customer_action_subscribe" value="2" <?php if ($simple_customer_action_subscribe == 2) { ?>checked="checked"<?php } ?>><?php echo $text_user_choice ?></label>
                <?php if (isset($error_simple_customer_action_subscribe)) { ?>
                <span class="error"><?php echo $error_simple_customer_action_subscribe ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr id="customer_subscribe_init" <?php if ($simple_customer_action_subscribe != 2) { ?>style="display:none"<?php } ?>>
            <td>
                <?php echo $entry_customer_subscribe_init; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_view_customer_subscribe_init" value="1" <?php if ($simple_customer_view_customer_subscribe_init) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_view_customer_subscribe_init" value="0" <?php if (!$simple_customer_view_customer_subscribe_init) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_view_customer_subscribe_init)) { ?>
                <span class="error"><?php echo $error_simple_customer_view_customer_subscribe_init ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_customer_login; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_view_login" value="1" <?php if ($simple_customer_view_login) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_view_login" value="0" <?php if (!$simple_customer_view_login) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_view_login)) { ?>
                <span class="error"><?php echo $error_simple_customer_view_login ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_customer_address_select; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_view_address_select" value="1" <?php if ($simple_customer_view_address_select) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_view_address_select" value="0" <?php if (!$simple_customer_view_address_select) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_view_address_select)) { ?>
                <span class="error"><?php echo $error_simple_customer_view_address_select ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_customer_type; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_customer_view_customer_type" value="1" <?php if ($simple_customer_view_customer_type) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_customer_view_customer_type" value="0" <?php if (!$simple_customer_view_customer_type) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_customer_view_customer_type)) { ?>
                <span class="error"><?php echo $error_simple_customer_view_customer_type ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_customer_fields; ?>
            </td>
            <td>
                <div id="msc_simple_customer_fields_set_default"></div>
                <input type="hidden" name="simple_customer_fields_set[default]" id="simple_customer_fields_set_default" value="<?php echo isset($simple_customer_fields_set['default']) ? $simple_customer_fields_set['default'] : "" ?>" />
                <select style="margin-top:5px;" id="customer_fields_default">
                <option value=""><?php echo $text_select ?></option>
                <?php foreach ($simple_customer_all_fields_settings as $key => $settings) { ?>
                <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                <?php } ?>
                </select>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_company_fields; ?>
            </td>
            <td>
                <div id="msc_simple_company_fields_set_default"></div>
                <input type="hidden" name="simple_company_fields_set[default]" id="simple_company_fields_set_default" value="<?php echo isset($simple_company_fields_set['default']) ? $simple_company_fields_set['default'] : "" ?>" />
                <select style="margin-top:5px;" id="company_fields_default">
                <option value=""><?php echo $text_select ?></option>
                <?php foreach ($simple_company_fields_settings as $key => $settings) { ?>
                <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                <?php } ?>
                </select>
            </td>  
          </tr>
        </table>
        <h3><?php echo $text_shipping_address_block ?></h3>
        <table class="form">
          <tr>
            <td>
                <?php echo $entry_shipping_address_show; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_show_shipping_address" value="1" <?php if ($simple_show_shipping_address) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_show_shipping_address" value="0" <?php if (!$simple_show_shipping_address) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_show_shipping_address)) { ?>
                <span class="error"><?php echo $error_simple_show_shipping_address ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_shipping_address_select; ?>
            </td>
            <td>
                <label><input type="radio" name="simple_shipping_view_address_select" value="1" <?php if ($simple_shipping_view_address_select) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                <label><input type="radio" name="simple_shipping_view_address_select" value="0" <?php if (!$simple_shipping_view_address_select) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                <?php if (isset($error_simple_shipping_view_address_select)) { ?>
                <span class="error"><?php echo $error_simple_shipping_view_address_select ?></span>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_shipping_address_fields; ?>
            </td>
            <td>
                <div id="msc_simple_shipping_address_fields_set_default"></div>
                <input type="hidden" name="simple_shipping_address_fields_set[default]" id="simple_shipping_address_fields_set_default" value="<?php echo isset($simple_shipping_address_fields_set['default']) ? $simple_shipping_address_fields_set['default'] : "" ?>" />
                <select style="margin-top:5px;" id="shipping_address_fields_default">
                <option value=""><?php echo $text_select ?></option>
                <?php foreach ($simple_shipping_address_fields_settings as $key => $settings) { ?>
                <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                <?php } ?>
                </select>
            </td>  
          </tr>
        </table>
        <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_shipping_module; ?></td>
                <td class="left"><?php echo $entry_customer_fields; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
              <tr>
                <td style="width:20%"><?php echo $shipping_name ?><span class="help"><?php echo $shipping_code ?></span></td>
                <td style="padding:5px;">
                    <div id="msc_simple_customer_fields_set_<?php echo $shipping_code ?>"></div>
                    <input type="hidden" name="simple_customer_fields_set[shipping][<?php echo $shipping_code ?>]" id="simple_customer_fields_set_<?php echo $shipping_code ?>" value="<?php echo isset($simple_customer_fields_set['shipping'][$shipping_code]) ? $simple_customer_fields_set['shipping'][$shipping_code] : "" ?>" />
                    <select style="margin-top:5px;" id="customer_fields_<?php echo $shipping_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_customer_all_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>
              </tr>
              <?php } ?>
              <?php foreach ($shipping_extensions_for_customer as $code) { ?>
              <tr>
                <?php 
                    $text = '';
                    $parts = explode('.', $code); 
                    if (count($parts) == 2) {
                        $text = isset($shipping_extensions[$parts[0]]) ? $shipping_extensions[$parts[0]] : $code;
                    }
                ?>
                <td style="width:20%"><?php echo $text ?><span class="help"><?php echo $code ?></span></td>
                <?php $shipping_code = str_replace('.','_101_', $code) ?>
                <td style="padding:5px;">
                    <div id="msc_simple_customer_fields_set_<?php echo $shipping_code ?>"></div>
                    <input type="hidden" name="simple_customer_fields_set[shipping][<?php echo $shipping_code ?>]" id="simple_customer_fields_set_<?php echo $shipping_code ?>" value="<?php echo isset($simple_customer_fields_set['shipping'][$code]) ? $simple_customer_fields_set['shipping'][$code] : "" ?>" />
                    <select style="margin-top:5px;" id="customer_fields_<?php echo $shipping_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_customer_all_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                    <br><a style="margin-top:5px" onclick="$(this).parent().parent().remove()" class="button"><?php echo $button_delete; ?></a>
                </td>
              </tr>
              <?php } ?>
              <tr>
                <td style="padding:5px;">
                    <select>
                    <?php foreach ($shipping_extensions as $key => $value) { ?>
                    <option value="<?php echo $key ?>"><?php echo $key ?></option>
                    <?php } ?>
                    </select><input type="text" name="shipping_code_for_customer" id="shipping_code_for_customer" value="">
                    <span class="help">Example citylink.citylink1</span>
                </td>
                <td style="padding:5px;">
                    <a onclick="add_shipping_method_for_customer()" class="button"><?php echo $button_add; ?></a>
                </td>  
              </tr>
            </tbody>
          </table>
        <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_shipping_module; ?></td>
                <td class="left"><?php echo $entry_company_fields; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
              <tr>
                <td style="width:20%"><?php echo $shipping_name ?><span class="help"><?php echo $shipping_code ?></span></td>
                <td style="padding:5px;">
                    <div id="msc_simple_company_fields_set_<?php echo $shipping_code ?>"></div>
                    <input type="hidden" name="simple_company_fields_set[shipping][<?php echo $shipping_code ?>]" id="simple_company_fields_set_<?php echo $shipping_code ?>" value="<?php echo isset($simple_company_fields_set['shipping'][$shipping_code]) ? $simple_company_fields_set['shipping'][$shipping_code] : "" ?>" />
                    <select style="margin-top:5px;" id="company_fields_<?php echo $shipping_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_company_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>
              </tr>
              <?php } ?>
              <?php foreach ($shipping_extensions_for_company as $code) { ?>
              <tr>
                <?php 
                    $text = '';
                    $parts = explode('.', $code); 
                    if (count($parts) == 2) {
                        $text = isset($shipping_extensions[$parts[0]]) ? $shipping_extensions[$parts[0]] : $code;
                    }
                ?>
                <td style="width:20%"><?php echo $text ?><span class="help"><?php echo $code ?></span></td>
                <?php $shipping_code = str_replace('.','_101_', $code) ?>
                <td style="padding:5px;">
                    <div id="msc_simple_company_fields_set_<?php echo $shipping_code ?>"></div>
                    <input type="hidden" name="simple_company_fields_set[shipping][<?php echo $shipping_code ?>]" id="simple_company_fields_set_<?php echo $shipping_code ?>" value="<?php echo isset($simple_company_fields_set['shipping'][$code]) ? $simple_company_fields_set['shipping'][$code] : "" ?>" />
                    <select style="margin-top:5px;" id="company_fields_<?php echo $shipping_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_company_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                    <br><a style="margin-top:5px" onclick="$(this).parent().parent().remove()" class="button"><?php echo $button_delete; ?></a>
                </td>
              </tr>
              <?php } ?>
              <tr>
                <td style="padding:5px;">
                    <select>
                    <?php foreach ($shipping_extensions as $key => $value) { ?>
                    <option value="<?php echo $key ?>"><?php echo $key ?></option>
                    <?php } ?>
                    </select><input type="text" name="shipping_code_for_company" id="shipping_code_for_company" value="">
                    <span class="help">Example citylink.citylink1</span>
                </td>
                <td style="padding:5px;">
                    <a onclick="add_shipping_method_for_company()" class="button"><?php echo $button_add; ?></a>
                </td>  
              </tr>
            </tbody>
          </table>
        <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_shipping_module; ?></td>
                <td class="left"><?php echo $entry_shipping_address_fields; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
              <tr>
                <td style="width:20%"><?php echo $shipping_name ?><span class="help"><?php echo $shipping_code ?></span></td>
                <td style="padding:5px;">
                    <div id="msc_simple_shipping_address_fields_set_<?php echo $shipping_code ?>"></div>
                    <input type="hidden" name="simple_shipping_address_fields_set[shipping][<?php echo $shipping_code ?>]" id="simple_shipping_address_fields_set_<?php echo $shipping_code ?>" value="<?php echo isset($simple_shipping_address_fields_set['shipping'][$shipping_code]) ? $simple_shipping_address_fields_set['shipping'][$shipping_code] : "" ?>" />
                    <select style="margin-top:5px;" id="shipping_address_fields_<?php echo $shipping_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_shipping_address_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>
              </tr>
              <?php } ?>
              <?php foreach ($shipping_extensions_for_shipping_address as $code) { ?>
              <tr>
                <?php 
                    $text = '';
                    $parts = explode('.', $code); 
                    if (count($parts) == 2) {
                        $text = isset($shipping_extensions[$parts[0]]) ? $shipping_extensions[$parts[0]] : $code;
                    }
                ?>
                <td style="width:20%"><?php echo $text ?><span class="help"><?php echo $code ?></span></td>
                <?php $shipping_code = str_replace('.','_101_', $code) ?>
                <td style="padding:5px;">
                    <div id="msc_simple_shipping_address_fields_set_<?php echo $shipping_code ?>"></div>
                    <input type="hidden" name="simple_shipping_address_fields_set[shipping][<?php echo $shipping_code ?>]" id="simple_shipping_address_fields_set_<?php echo $shipping_code ?>" value="<?php echo isset($simple_shipping_address_fields_set['shipping'][$code]) ? $simple_shipping_address_fields_set['shipping'][$code] : "" ?>" />
                    <select style="margin-top:5px;" id="shipping_address_fields_<?php echo $shipping_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_shipping_address_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                    <br><a style="margin-top:5px" onclick="$(this).parent().parent().remove()" class="button"><?php echo $button_delete; ?></a>
                </td>
              </tr>
              <?php } ?>
              <tr>
                <td style="padding:5px;">
                    <select>
                    <?php foreach ($shipping_extensions as $key => $value) { ?>
                    <option value="<?php echo $key ?>"><?php echo $key ?></option>
                    <?php } ?>
                    </select><input type="text" name="shipping_code_for_shipping" id="shipping_code_for_shipping" value="">
                    <span class="help">Example citylink.citylink1</span>
                </td>
                <td style="padding:5px;">
                    <a onclick="add_shipping_method_for_shipping()" class="button"><?php echo $button_add; ?></a>
                </td>  
              </tr>
            </tbody>
          </table>
          <!-- start of sets for payment methods -->
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_payment_method; ?></td>
                <td class="left"><?php echo $entry_customer_fields; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
              <tr>
                <td style="width:20%"><?php echo $payment_name ?><span class="help"><?php echo $payment_code ?></span></td>
                <td style="padding:5px;">
                    <div id="msc_simple_customer_fields_set_<?php echo $payment_code ?>"></div>
                    <input type="hidden" name="simple_customer_fields_set[payment][<?php echo $payment_code ?>]" id="simple_customer_fields_set_<?php echo $payment_code ?>" value="<?php echo isset($simple_customer_fields_set['payment'][$payment_code]) ? $simple_customer_fields_set['payment'][$payment_code] : "" ?>" />
                    <select style="margin-top:5px;" id="customer_fields_<?php echo $payment_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_customer_all_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_payment_method; ?></td>
                <td class="left"><?php echo $entry_company_fields; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
              <tr>
                <td style="width:20%"><?php echo $payment_name ?><span class="help"><?php echo $payment_code ?></span></td>
                <td style="padding:5px;">
                    <div id="msc_simple_company_fields_set_<?php echo $payment_code ?>"></div>
                    <input type="hidden" name="simple_company_fields_set[payment][<?php echo $payment_code ?>]" id="simple_company_fields_set_<?php echo $payment_code ?>" value="<?php echo isset($simple_company_fields_set['payment'][$payment_code]) ? $simple_company_fields_set['payment'][$payment_code] : "" ?>" />
                    <select style="margin-top:5px;" id="company_fields_<?php echo $payment_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_company_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_payment_method; ?></td>
                <td class="left"><?php echo $entry_shipping_address_fields; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
              <tr>
                <td style="width:20%"><?php echo $payment_name ?><span class="help"><?php echo $payment_code ?></span></td>
                <td style="padding:5px;">
                    <div id="msc_simple_shipping_address_fields_set_<?php echo $payment_code ?>"></div>
                    <input type="hidden" name="simple_shipping_address_fields_set[payment][<?php echo $payment_code ?>]" id="simple_shipping_address_fields_set_<?php echo $payment_code ?>" value="<?php echo isset($simple_shipping_address_fields_set['payment'][$payment_code]) ? $simple_shipping_address_fields_set['payment'][$payment_code] : "" ?>" />
                    <select style="margin-top:5px;" id="shipping_address_fields_<?php echo $payment_code ?>">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_shipping_address_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
          <!-- end of sets for payment methods -->
        <h3><?php echo $text_module_links ?></h3>
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_payment_module; ?></td>
                <td class="left"><?php echo $entry_shipping_modules; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
              <tr>
                <td style="width:20%"><?php echo $payment_name ?></td>
                <td style="padding:5px;">
                    <div id="msc_<?php echo $payment_code ?>"></div>
                    <input type="text" name="simple_links[<?php echo $payment_code ?>]" id="simple_links_<?php echo $payment_code ?>" value="<?php echo isset($simple_links[$payment_code]) ? $simple_links[$payment_code] : "" ?>" size="100" /><br>
                    <span class="help">Example: citylink - for all methods for this module, citylink.citylink1 - only for submethod citylink1 of module citylink</span>
                    <select style="margin-top:5px;" id="<?php echo $payment_code ?>">
                    <option value=""><?php echo $text_select_shipping ?></option>
                    <?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
                    <option value="<?php echo $shipping_code ?>"><?php echo $shipping_name ?></option>
                    <?php } ?>
                    </select>
                </td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
      </div>
      <div id="tab-customer-fields">
        <div class="fields-list">
        <?php foreach ($simple_customer_all_fields_settings as $field) { ?>
        <?php if (substr($field['id'], 0, 4) == 'main') { ?>
        <table class="form" style="margin-bottom:50px;">
          <tr>
            <td>
                <?php echo $entry_field_id; ?>
            </td>
            <td>
                <h3><?php echo !empty($field['label'][$current_language]) ? $field['id'].' ('.$field['label'][$current_language].')' : $field['id'] ?></h3>
                <input type="hidden" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][id]" value="<?php echo $field['id'] ?>">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_label; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][label][<?php echo $language['code'] ?>]" value="<?php echo !empty($field['label'][$language['code']]) ? $field['label'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_type; ?>
            </td>
            <td>
                <?php echo $field['type'] ?>
                <input type="hidden" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][type]" value="<?php echo $field['type'] ?>">
            </td>  
          </tr>
          <tr <?php if ($field['type'] == 'text' || $field['type'] == 'textarea' || $field['type'] == 'select_from_api') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_values; ?>
            </td>
            <td>
                <?php echo $field['values'] ?>
                <input type="hidden" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][values]" value="<?php echo $field['values'] ?>">
            </td>  
          </tr>
          <tr <?php if (($field['type'] == 'text' && $field['id'] != 'main_postcode' && $field['id'] != 'main_city') || $field['type'] == 'textarea' || $field['type'] == 'select_from_api') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td>
                <?php if ($field['type'] == 'select' && $field['values'] == 'countries') { ?>
                    <select id="country_id" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][init]" onchange="$('#zone_id').load('<?php echo $zone_action ?>&country_id=' + this.value);">
                        <option value="0"><?php echo $text_select ?></option>
                        <?php foreach ($countries as $country) { ?>
                        <option value="<?php echo $country['country_id'] ?>" <?php if ($country['country_id'] == $field['init']) { ?>selected="selected"<?php } ?>><?php echo $country['name'] ?></option>
                        <?php } ?>
                    </select>
                <?php } elseif ($field['type'] == 'select' && $field['values'] == 'zones') { ?>
                    <select id="zone_id" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][init]">
                        <option value="0"><?php echo $text_select ?></option>
                        <?php foreach ($zones as $zone) { ?>
                        <option value="<?php echo $zone['zone_id'] ?>" <?php if ($zone['zone_id'] == $field['init']) { ?>selected="selected"<?php } ?>><?php echo $zone['name'] ?></option>
                        <?php } ?>
                    </select>
                <?php } elseif ($field['id'] == 'main_city' || $field['id'] == 'main_postcode') { ?>
                    <input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][init]" value="<?php echo !empty($field['init']) ? $field['init'] : '' ?>">
                <?php } else { ?>                
                    <?php echo $field['init'] ?>
                    <input type="hidden" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][init]" value="<?php echo $field['init'] ?>">
                <?php } ?>
                <?php if ($field['id'] == 'main_country_id' || $field['id'] == 'main_zone_id' || $field['id'] == 'main_city' || $field['id'] == 'main_postcode') { ?>
                    <br><label><input type="checkbox" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][init_geoip]" value="1" <?php echo !empty($field['init_geoip']) ? 'checked="checked"' : '' ?>><?php echo $entry_geoip_init ?></label>
                <?php } ?>
                <?php if ($field['id'] == 'main_city') { ?>
                    <br><label><input type="checkbox" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][autocomplete]" value="1" <?php echo !empty($field['autocomplete']) ? 'checked="checked"' : '' ?>><?php echo $entry_city_autocomplete ?></label>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation; ?>
            </td>
            <td>
                <?php if ($field['id'] != 'main_email') { ?>
                <div><input type="radio" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="0" <?php if ($field['validation_type'] == 0) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_none ?></div>
                <div><input type="radio" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="1" <?php if ($field['validation_type'] == 1) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_not_null ?></div>
                <div><input type="radio" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="2" <?php if ($field['validation_type'] == 2) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_length ?> min: <input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_min]" size="5" value="<?php echo $field['validation_min'] ?>"> max: <input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_max]" size="5" value="<?php echo $field['validation_max'] ?>"></div>
                <div><input type="radio" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="3" <?php if ($field['validation_type'] == 3) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_regexp ?> <input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_regexp]" size="40" value="<?php echo $field['validation_regexp'] ?>"></div>
                <div><input type="radio" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="4" <?php if ($field['validation_type'] == 4) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_values ?></div>
                <div><input type="radio" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="5" <?php if ($field['validation_type'] == 5) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_function ?> validate_<?php echo $field['id'] ?></div>
                <?php } else { ?>
                <div><input type="radio" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="3" <?php if ($field['validation_type'] == 3) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_regexp ?> <input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_regexp]" size="40" value="<?php echo $field['validation_regexp'] ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation_error; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][validation_error][<?php echo $language['code'] ?>]" size="80" value="<?php echo !empty($field['validation_error'][$language['code']]) ? $field['validation_error'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_save_to; ?>
            </td>
            <td>
                <?php echo $field['save_to'] ?>
                <input type="hidden" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][save_to]" value="<?php echo $field['save_to'] ?>">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_jquery_masked_input_mask; ?>
            </td>
            <td>
                <input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][mask]" value="<?php echo !empty($field['mask']) ? $field['mask'] : '' ?>">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_placeholder; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_customer_fields_settings[<?php echo $field['id'] ?>][placeholder][<?php echo $language['code'] ?>]" size="80" value="<?php echo !empty($field['placeholder'][$language['code']]) ? $field['placeholder'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>                    
        </table>
        <?php } elseif (substr($field['id'], 0, 6) == 'custom') { ?>
        <table id="<?php echo $field['id'] ?>" class="form" style="margin-bottom:50px;">
          <tr>
            <td>
                <?php echo $entry_field_id; ?>
            </td>
            <td>
                <h3><?php echo !empty($field['label'][$current_language]) ? $field['id'].' ('.$field['label'][$current_language].')' : $field['id'] ?></h3>
                <input type="hidden" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][id]" value="<?php echo $field['id'] ?>">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_label; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][label][<?php echo $language['code'] ?>]" value="<?php echo !empty($field['label'][$language['code']]) ? $field['label'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_type; ?>
            </td>
            <td>
                <select class="type" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][type]">
                    <option value="text" <?php echo $field['type'] == 'text' ? 'selected="selected"' : '' ?>>text</option>
                    <option value="textarea" <?php echo $field['type'] == 'textarea' ? 'selected="selected"' : '' ?>>textarea</option>
                    <option value="radio" <?php echo $field['type'] == 'radio' ? 'selected="selected"' : '' ?>>radio</option>
                    <option value="select" <?php echo $field['type'] == 'select' ? 'selected="selected"' : '' ?>>select</option>
                    <option value="select_from_api" <?php echo $field['type'] == 'select_from_api' ? 'selected="selected"' : '' ?>>select_from_api</option>
                    <option value="date" <?php echo $field['type'] == 'date' ? 'selected="selected"' : '' ?>>jquery date</option>
                </select>
            </td>  
          </tr>
          <tr class="row_values" <?php if ($field['type'] == 'text' || $field['type'] == 'textarea' || $field['type'] == 'select_from_api' || $field['type'] == 'date') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_values; ?>
            </td>
            <td>
                <?php $values = '' ?>
                <?php foreach ($languages as $language) { ?>
                <img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<textarea name="simple_custom_fields_settings[<?php echo $field['id'] ?>][values][<?php echo $language['code'] ?>]" cols="150"><?php echo !empty($field['values'][$language['code']]) ? $field['values'][$language['code']] : '' ?></textarea><br />
                <?php $values = (empty($values) && !empty($field['values'][$language['code']])) ? $field['values'][$language['code']] : $values ?>
                <?php } ?>
                <span class="help">
                Example: value1=text1;value2=text2;value3=text3
                </span>
            </td>  
          </tr>
          <tr class="row_init" <?php if ($field['type'] == 'text' || $field['type'] == 'textarea' || $field['type'] == 'select_from_api' || $field['type'] == 'date') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="init">
                <?php $values = explode(';', $values); ?>
                <?php if (count($values) > 0) { ?>
                    <?php if ($field['type'] == 'select') { ?>
                        <select name="simple_custom_fields_settings[<?php echo $field['id'] ?>][init]">
                    <?php } ?>
                    <?php foreach ($values as $value) { ?>
                        <?php $r = explode('=', $value, 2); ?>
                        <?php if (count($r) == 2) { ?>
                            <?php if ($field['type'] == 'radio') { ?>
                                <label><input name="simple_custom_fields_settings[<?php echo $field['id'] ?>][init]" type="radio" value="<?php echo $r[0] ?>" <?php echo $r[0] == $field['init'] ? 'checked="checked"' : '' ?>><?php echo $r[1] ?></label><br>
                            <?php } elseif ($field['type'] == 'select') { ?>
                                <option value="<?php echo $r[0] ?>" <?php echo $r[0] == $field['init'] ? 'selected="selected"' : '' ?>><?php echo $r[1] ?></option>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                    <?php if ($field['type'] == 'select') { ?>
                        </select>
                    <?php } ?>
                <?php } ?>
            </td>  
          </tr>
          <tr class="row_date" <?php if ($field['type'] != 'date') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="date">
                min date: <input name="simple_custom_fields_settings[<?php echo $field['id'] ?>][date_min]" type="text" class="datepicker" value="<?php echo !empty($field['date_min']) ? $field['date_min'] : '' ?>" > or start date after current date: <input name="simple_custom_fields_settings[<?php echo $field['id'] ?>][date_start]" type="text" size="1" value="<?php echo !empty($field['date_start']) ? $field['date_start'] : '' ?>" ><br>
                max date: <input name="simple_custom_fields_settings[<?php echo $field['id'] ?>][date_max]" type="text" class="datepicker" value="<?php echo !empty($field['date_max']) ? $field['date_max'] : '' ?>" > or end date after current date: <input name="simple_custom_fields_settings[<?php echo $field['id'] ?>][date_end]" type="text" size="1" value="<?php echo !empty($field['date_end']) ? $field['date_end'] : '' ?>" ><br>
                only business days: <input name="simple_custom_fields_settings[<?php echo $field['id'] ?>][date_only_business]" type="checkbox" value="1" <?php echo !empty($field['date_only_business']) ? 'checked="checked"' : '' ?>>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation; ?>
            </td>
            <td>
                <div><input type="radio" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="0" <?php if ($field['validation_type'] == 0) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_none ?></div>
                <div><input type="radio" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="1" <?php if ($field['validation_type'] == 1) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_not_null ?></div>
                <div><input type="radio" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="2" <?php if ($field['validation_type'] == 2) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_length ?> min: <input type="text" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_min]" size="5" value="<?php echo $field['validation_min'] ?>"> max: <input type="text" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_max]" size="5" value="<?php echo $field['validation_max'] ?>"></div>
                <div><input type="radio" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="3" <?php if ($field['validation_type'] == 3) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_regexp ?> <input type="text" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_regexp]" size="40" value="<?php echo $field['validation_regexp'] ?>"></div>
                <div><input type="radio" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="4" <?php if ($field['validation_type'] == 4) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_values ?></div>
                <div><input type="radio" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="5" <?php if ($field['validation_type'] == 5) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_function ?> validate_<?php echo $field['id'] ?></div>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation_error; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][validation_error][<?php echo $language['code'] ?>]" size="80" value="<?php echo !empty($field['validation_error'][$language['code']]) ? $field['validation_error'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_save_to; ?>
            </td>
            <td>
                <select name="simple_custom_fields_settings[<?php echo $field['id'] ?>][save_to]">
                    <option value="" <?php echo empty($field['save_to'])? 'selected="selected"' : '' ?>></option>
                    <option value="firstname" <?php echo $field['save_to'] == 'firstname' ? 'selected="selected"' : '' ?>>firstname</option>
                    <option value="lastname" <?php echo $field['save_to'] == 'lastname' ? 'selected="selected"' : '' ?>>lastname</option>
                    <option value="telephone" <?php echo $field['save_to'] == 'telephone' ? 'selected="selected"' : '' ?>>telephone</option>
                    <option value="fax" <?php echo $field['save_to'] == 'fax' ? 'selected="selected"' : '' ?>>fax</option>
                    <option value="company" <?php echo $field['save_to'] == 'company' ? 'selected="selected"' : '' ?>>company</option>
                    <option value="company_id" <?php echo $field['save_to'] == 'company_id' ? 'selected="selected"' : '' ?>>company_id</option>
                    <option value="tax_id" <?php echo $field['save_to'] == 'tax_id' ? 'selected="selected"' : '' ?>>tax_id</option>
                    <option value="address_1" <?php echo $field['save_to'] == 'address_1' ? 'selected="selected"' : '' ?>>address_1</option>
                    <option value="address_2" <?php echo $field['save_to'] == 'address_2' ? 'selected="selected"' : '' ?>>address_2</option>
                    <option value="postcode" <?php echo $field['save_to'] == 'postcode' ? 'selected="selected"' : '' ?>>postcode</option>
                    <option value="city" <?php echo $field['save_to'] == 'city' ? 'selected="selected"' : '' ?>>city</option>
                    <option value="comment" <?php echo $field['save_to'] == 'comment' ? 'selected="selected"' : '' ?>>comment</option>
                </select>
                <br><label><input type="checkbox" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][save_label]" value="1" <?php echo !empty($field['save_label']) ? 'checked="checked"' : '' ?>><?php echo $entry_save_label ?></label>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_jquery_masked_input_mask; ?>
            </td>
            <td>
                <input type="text" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][mask]" value="<?php echo !empty($field['mask']) ? $field['mask'] : '' ?>">
            </td>  
          </tr>     
          <tr>
            <td>
                <?php echo $entry_placeholder; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_custom_fields_settings[<?php echo $field['id'] ?>][placeholder][<?php echo $language['code'] ?>]" size="80" value="<?php echo !empty($field['placeholder'][$language['code']]) ? $field['placeholder'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>                 
          <tr>
            <td>
            </td>
            <td>
                <a onclick="$('#<?php echo $field['id'] ?>').remove()" class="button"><?php echo $button_delete; ?></a>
            </td>  
          </tr>
        </table>
        <?php } ?>
        <?php } ?>
        </div>
        <h3><?php echo $text_add_field ?></h3>
        <table id="custom_new_field" class="form" style="margin-bottom:50px;">
          <tr>
            <td>
                <?php echo $entry_field_id; ?>
            </td>
            <td>
                <span style="margin-left:-50px;">custom_</span>
                <input type="text" name="id" value="">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_label; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="label_<?php echo $language['code'] ?>" value=""></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_type; ?>
            </td>
            <td>
                <select class="type" name="type">
                    <option value="text">text</option>
                    <option value="textarea">textarea</option>
                    <option value="radio">radio</option>
                    <option value="select">select</option>
                    <option value="select_from_api">select_from_api</option>
                    <option value="date">jquery date</option>
                </select>
            </td>  
          </tr>
          <tr class="row_date" style="display:none;">
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="date">
                min date: <input name="date_min" type="text" class="datepicker" value="" > or start date after current date: <input name="date_start" type="text" size="1" value="" ><br>
                max date: <input name="date_max" type="text" class="datepicker" value="" > or end date after current date: <input name="date_end" type="text" size="1" value="" ><br>
                only business days: <input name="date_only_business" type="checkbox" value="1" >
            </td>  
          </tr>
          <tr class="row_values" style="display:none;">
            <td>
                <?php echo $entry_field_values; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<textarea name="values_<?php echo $language['code'] ?>" cols="150"></textarea><br />
                <?php } ?>
                <span class="help">
                Example: value1=text1;value2=text2;value3=text3
                </span>
            </td>  
          </tr>
          <tr class="row_init" style="display:none;">
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="init">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation; ?>
            </td>
            <td>
                <div><input type="radio" name="validation_type" value="0" checked="checked">&nbsp;<?php echo $text_validation_none ?></div>
                <div><input type="radio" name="validation_type" value="1">&nbsp;<?php echo $text_validation_not_null ?></div>
                <div><input type="radio" name="validation_type" value="2">&nbsp;<?php echo $text_validation_length ?> min: <input type="text" name="validation_min" size="5" value=""> max: <input type="text" name="validation_max" size="5" value=""></div>
                <div><input type="radio" name="validation_type" value="3">&nbsp;<?php echo $text_validation_regexp ?> <input type="text" name="validation_regexp" size="40" value=""></div>
                <div><input type="radio" name="validation_type" value="4">&nbsp;<?php echo $text_validation_values ?></div>
                <div><input type="radio" name="validation_type" value="5">&nbsp;<?php echo $text_validation_function ?> validate_custom_{id}</div>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation_error; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="validation_error_<?php echo $language['code'] ?>" size="80" value=""></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_save_to; ?>
            </td>
            <td>
                <select name="save_to">
                    <option value=""></option>
                    <option value="firstname">firstname</option>
                    <option value="lastname">lastname</option>
                    <option value="telephone">telephone</option>
                    <option value="fax">fax</option>
                    <option value="company">company</option>
                    <option value="company_id">company_id</option>
                    <option value="tax_id">tax_id</option>
                    <option value="address_1">address_1</option>
                    <option value="address_2">address_2</option>
                    <option value="postcode">postcode</option>
                    <option value="city">city</option>
                    <option value="comment" selected="selected">comment</option>
                </select>
                <br><label><input type="checkbox" name="save_label" value="1"><?php echo $entry_save_label ?></label>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_jquery_masked_input_mask; ?>
            </td>
            <td>
                <input type="text" name="mask" value="">
            </td>  
          </tr>   
          <tr>
            <td>
                <?php echo $entry_placeholder; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="placeholder_<?php echo $language['code'] ?>" size="80" value=""></div>
                <?php } ?>
            </td>  
          </tr>                  
          <tr>
            <td>
            </td>
            <td>
                <a onclick="add_field('#custom_new_field','#tab-customer-fields div.fields-list', 'simple_custom_fields_settings', 'custom_')" class="button"><?php echo $button_add; ?></a>
            </td>  
          </tr>
        </table>
      </div>
      <div id="tab-company-fields">
        <div class="fields-list">
        <?php if (!empty($simple_company_fields_settings)) { ?>
        <?php foreach ($simple_company_fields_settings as $field) { ?>
        <table id="<?php echo $field['id'] ?>" class="form" style="margin-bottom:50px;">
          <tr>
            <td>
                <?php echo $entry_field_id; ?>
            </td>
            <td>
                <h3><?php echo !empty($field['label'][$current_language]) ? $field['id'].' ('.$field['label'][$current_language].')' : $field['id'] ?></h3>
                <input type="hidden" name="simple_company_fields_settings[<?php echo $field['id'] ?>][id]" value="<?php echo $field['id'] ?>">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_label; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_company_fields_settings[<?php echo $field['id'] ?>][label][<?php echo $language['code'] ?>]" value="<?php echo !empty($field['label'][$language['code']]) ? $field['label'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_type; ?>
            </td>
            <td>
                <select class="type" name="simple_company_fields_settings[<?php echo $field['id'] ?>][type]">
                    <option value="text" <?php echo $field['type'] == 'text' ? 'selected="selected"' : '' ?>>text</option>
                    <option value="textarea" <?php echo $field['type'] == 'textarea' ? 'selected="selected"' : '' ?>>textarea</option>
                    <option value="radio" <?php echo $field['type'] == 'radio' ? 'selected="selected"' : '' ?>>radio</option>
                    <option value="select" <?php echo $field['type'] == 'select' ? 'selected="selected"' : '' ?>>select</option>
                    <option value="select_from_api" <?php echo $field['type'] == 'select_from_api' ? 'selected="selected"' : '' ?>>select_from_api</option>
                    <option value="date" <?php echo $field['type'] == 'date' ? 'selected="selected"' : '' ?>>jquery date</option>
                </select>
            </td>  
          </tr>
          <tr class="row_values" <?php if ($field['type'] == 'text' || $field['type'] == 'textarea' || $field['type'] == 'select_from_api' || $field['type'] == 'date') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_values; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<textarea name="simple_company_fields_settings[<?php echo $field['id'] ?>][values][<?php echo $language['code'] ?>]" cols="150"><?php echo !empty($field['values'][$language['code']]) ? $field['values'][$language['code']] : '' ?></textarea><br />
                <?php $values = !empty($field['values'][$language['code']]) ? $field['values'][$language['code']] : '' ?>
                <?php } ?>
                <span class="help">
                Example: value1=text1;value2=text2;value3=text3
                </span>
            </td>  
          </tr>
          <tr class="row_init" <?php if ($field['type'] == 'text' || $field['type'] == 'textarea' || $field['type'] == 'select_from_api' || $field['type'] == 'date') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="init">
                <?php $values = explode(';', $values); ?>
                <?php if (count($values) > 0) { ?>
                    <?php if ($field['type'] == 'select') { ?>
                        <select name="simple_company_fields_settings[<?php echo $field['id'] ?>][init]">
                    <?php } ?>
                    <?php foreach ($values as $value) { ?>
                        <?php $r = explode('=', $value, 2); ?>
                        <?php if (count($r) == 2) { ?>
                            <?php if ($field['type'] == 'radio') { ?>
                                <label><input name="simple_company_fields_settings[<?php echo $field['id'] ?>][init]" type="radio" value="<?php echo $r[0] ?>" <?php echo $r[0] == $field['init'] ? 'checked="checked"' : '' ?>><?php echo $r[1] ?></label><br>
                            <?php } elseif ($field['type'] == 'select') { ?>
                                <option value="<?php echo $r[0] ?>" <?php echo $r[0] == $field['init'] ? 'selected="selected"' : '' ?>><?php echo $r[1] ?></option>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                    <?php if ($field['type'] == 'select') { ?>
                        </select>
                    <?php } ?>
                <?php } ?>
            </td>  
          </tr>
          <tr class="row_date" <?php if ($field['type'] != 'date') { ?>style="display:none;"<?php } ?>>
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="date">
                min date: <input name="simple_company_fields_settings[<?php echo $field['id'] ?>][date_min]" type="text" class="datepicker" value="<?php echo !empty($field['date_min']) ? $field['date_min'] : '' ?>" > or start date after current date: <input name="simple_company_fields_settings[<?php echo $field['id'] ?>][date_start]" type="text" size="1" value="<?php echo !empty($field['date_start']) ? $field['date_start'] : '' ?>" ><br>
                max date: <input name="simple_company_fields_settings[<?php echo $field['id'] ?>][date_max]" type="text" class="datepicker" value="<?php echo !empty($field['date_max']) ? $field['date_max'] : '' ?>" > or end date after current date: <input name="simple_company_fields_settings[<?php echo $field['id'] ?>][date_end]" type="text" size="1" value="<?php echo !empty($field['date_end']) ? $field['date_end'] : '' ?>" ><br>
                only business days: <input name="simple_company_fields_settings[<?php echo $field['id'] ?>][date_only_business]" type="checkbox" value="1" <?php echo !empty($field['date_only_business']) ? 'checked="checked"' : '' ?>>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation; ?>
            </td>
            <td>
                <div><input type="radio" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="0" <?php if ($field['validation_type'] == 0) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_none ?></div>
                <div><input type="radio" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="1" <?php if ($field['validation_type'] == 1) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_not_null ?></div>
                <div><input type="radio" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="2" <?php if ($field['validation_type'] == 2) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_length ?> min: <input type="text" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_min]" size="5" value="<?php echo $field['validation_min'] ?>"> max: <input type="text" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_max]" size="5" value="<?php echo $field['validation_max'] ?>"></div>
                <div><input type="radio" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="3" <?php if ($field['validation_type'] == 3) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_regexp ?> <input type="text" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_regexp]" size="40" value="<?php echo $field['validation_regexp'] ?>"></div>
                <div><input type="radio" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="4" <?php if ($field['validation_type'] == 4) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_values ?></div>
                <div><input type="radio" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_type]" value="5" <?php if ($field['validation_type'] == 5) { ?>checked="checked"<?php } ?>>&nbsp;<?php echo $text_validation_function ?> validate_<?php echo $field['id'] ?></div>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation_error; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_company_fields_settings[<?php echo $field['id'] ?>][validation_error][<?php echo $language['code'] ?>]" size="80" value="<?php echo !empty($field['validation_error'][$language['code']]) ? $field['validation_error'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_save_to; ?>
            </td>
            <td>
                <select name="simple_company_fields_settings[<?php echo $field['id'] ?>][save_to]">
                    <option value="" <?php echo empty($field['save_to'])? 'selected="selected"' : '' ?>></option>
                    <option value="firstname" <?php echo $field['save_to'] == 'firstname' ? 'selected="selected"' : '' ?>>firstname</option>
                    <option value="lastname" <?php echo $field['save_to'] == 'lastname' ? 'selected="selected"' : '' ?>>lastname</option>
                    <option value="telephone" <?php echo $field['save_to'] == 'telephone' ? 'selected="selected"' : '' ?>>telephone</option>
                    <option value="fax" <?php echo $field['save_to'] == 'fax' ? 'selected="selected"' : '' ?>>fax</option>
                    <option value="company" <?php echo $field['save_to'] == 'company' ? 'selected="selected"' : '' ?>>company</option>
                    <option value="company_id" <?php echo $field['save_to'] == 'company_id' ? 'selected="selected"' : '' ?>>company_id</option>
                    <option value="tax_id" <?php echo $field['save_to'] == 'tax_id' ? 'selected="selected"' : '' ?>>tax_id</option>
                    <option value="address_1" <?php echo $field['save_to'] == 'address_1' ? 'selected="selected"' : '' ?>>address_1</option>
                    <option value="address_2" <?php echo $field['save_to'] == 'address_2' ? 'selected="selected"' : '' ?>>address_2</option>
                    <option value="postcode" <?php echo $field['save_to'] == 'postcode' ? 'selected="selected"' : '' ?>>postcode</option>
                    <option value="city" <?php echo $field['save_to'] == 'city' ? 'selected="selected"' : '' ?>>city</option>
                    <option value="comment" <?php echo $field['save_to'] == 'comment' ? 'selected="selected"' : '' ?>>comment</option>
                </select>
                <br><label><input type="checkbox" name="simple_company_fields_settings[<?php echo $field['id'] ?>][save_label]" value="1" <?php echo !empty($field['save_label']) ? 'checked="checked"' : '' ?>><?php echo $entry_save_label ?></label>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_jquery_masked_input_mask; ?>
            </td>
            <td>
                <input type="text" name="simple_company_fields_settings[<?php echo $field['id'] ?>][mask]" value="<?php echo !empty($field['mask']) ? $field['mask'] : '' ?>">
            </td>  
          </tr>   
          <tr>
            <td>
                <?php echo $entry_placeholder; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_company_fields_settings[<?php echo $field['id'] ?>][placeholder][<?php echo $language['code'] ?>]" size="80" value="<?php echo !empty($field['placeholder'][$language['code']]) ? $field['placeholder'][$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>                    
          <tr>
            <td>
            </td>
            <td>
                <a onclick="$('#<?php echo $field['id'] ?>').remove()" class="button"><?php echo $button_delete; ?></a>
            </td>  
          </tr>
        </table>
        <?php } ?>
        <?php } ?>
        </div>
        <h3><?php echo $text_add_field ?></h3>
        <table id="company_new_field" class="form" style="margin-bottom:50px;">
          <tr>
            <td>
                <?php echo $entry_field_id; ?>
            </td>
            <td>
                <span style="margin-left:-60px;">company_</span>
                <input type="text" name="id" value="">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_label; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="label_<?php echo $language['code'] ?>" value=""></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_type; ?>
            </td>
            <td>
                <select class="type" name="type">
                    <option value="text">text</option>
                    <option value="textarea">textarea</option>
                    <option value="radio">radio</option>
                    <option value="select">select</option>
                    <option value="select_from_api">select_from_api</option>
                    <option value="date">jquery date</option>
                </select>
            </td>  
          </tr>
          <tr class="row_date" style="display:none;">
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="date">
                min date: <input name="date_min" type="text" class="datepicker" value="" > or start date after current date: <input name="date_start" type="text" size="1" value="" ><br>
                max date: <input name="date_max" type="text" class="datepicker" value="" > or end date after current date: <input name="date_end" type="text" size="1" value="" ><br>
                only business days: <input name="date_only_business" type="checkbox" value="1" >
            </td>  
          </tr>
          <tr class="row_values" style="display:none;">
            <td>
                <?php echo $entry_field_values; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<textarea name="values_<?php echo $language['code'] ?>" cols="150"></textarea><br />
                <?php } ?>
                <span class="help">
                Example: value1=text1;value2=text2;value3=text3
                </span>
            </td>  
          </tr>
          <tr class="row_init" style="display:none;">
            <td>
                <?php echo $entry_field_init; ?>
            </td>
            <td id="init">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation; ?>
            </td>
            <td>
                <div><input type="radio" name="validation_type" value="0" checked="checked">&nbsp;<?php echo $text_validation_none ?></div>
                <div><input type="radio" name="validation_type" value="1">&nbsp;<?php echo $text_validation_not_null ?></div>
                <div><input type="radio" name="validation_type" value="2">&nbsp;<?php echo $text_validation_length ?> min: <input type="text" name="validation_min" size="5" value=""> max: <input type="text" name="validation_max" size="5" value=""></div>
                <div><input type="radio" name="validation_type" value="3">&nbsp;<?php echo $text_validation_regexp ?> <input type="text" name="validation_regexp" size="40" value=""></div>
                <div><input type="radio" name="validation_type" value="4">&nbsp;<?php echo $text_validation_values ?></div>
                <div><input type="radio" name="validation_type" value="5">&nbsp;<?php echo $text_validation_function ?> validate_company_{id}</div>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_validation_error; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="validation_error_<?php echo $language['code'] ?>" size="80" value=""></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_field_save_to; ?>
            </td>
            <td>
                <select name="save_to">
                    <option value=""></option>
                    <option value="firstname">firstname</option>
                    <option value="lastname">lastname</option>
                    <option value="telephone">telephone</option>
                    <option value="fax">fax</option>
                    <option value="company">company</option>
                    <option value="company_id">company_id</option>
                    <option value="tax_id">tax_id</option>
                    <option value="address_1">address_1</option>
                    <option value="address_2">address_2</option>
                    <option value="postcode">postcode</option>
                    <option value="city">city</option>
                    <option value="comment" selected="selected">comment</option>
                </select>
                <br><label><input type="checkbox" name="save_label" value="1"><?php echo $entry_save_label ?></label>
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_jquery_masked_input_mask; ?>
            </td>
            <td>
                <input type="text" name="mask" value="">
            </td>  
          </tr>
          <tr>
            <td>
                <?php echo $entry_placeholder; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="placeholder_<?php echo $language['code'] ?>" size="80" value=""></div>
                <?php } ?>
            </td>  
          </tr>                    
          <tr>
            <td>
            </td>
            <td>
                <a onclick="add_field('#company_new_field','#tab-company-fields div.fields-list', 'simple_company_fields_settings', 'company_')" class="button"><?php echo $button_add; ?></a>
            </td>  
          </tr>
        </table>
      </div>
      <div id="tab-registration">
        <h3><?php echo $text_registration_page ?></h3>
            <table class="form">
              <tr>
                <td>
                    <?php echo $entry_generate_password; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_generate_password" value="1" <?php if ($simple_registration_generate_password) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_generate_password" value="0" <?php if (!$simple_registration_generate_password) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <?php if (isset($error_simple_registration_generate_password)) { ?>
                    <span class="error"><?php echo $error_simple_registration_generate_password ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_customer_password_confirm; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_password_confirm" value="1" <?php if ($simple_registration_password_confirm) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_password_confirm" value="0" <?php if (!$simple_registration_password_confirm) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <?php if (isset($error_simple_registration_password_confirm)) { ?>
                    <span class="error"><?php echo $error_simple_registration_password_confirm ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_password_length; ?>
                </td>
                <td>
                    min <input type="text" size="3" name="simple_registration_password_length_min" value="<?php echo $simple_registration_password_length_min ?>" >
                    max <input type="text" size="3" name="simple_registration_password_length_max" value="<?php echo $simple_registration_password_length_max ?>" >
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_registration_agreement_id; ?>
                </td>
                <td>
                    <select name="simple_registration_agreement_id">
                        <option value="0"><?php echo $text_select ?></option>
                        <?php foreach ($informations as $information) { ?>
                        <option value="<?php echo $information['information_id'] ?>" <?php if ($information['information_id'] == $simple_registration_agreement_id) { ?>selected="selected"<?php } ?>><?php echo $information['title'] ?></option>
                        <?php } ?>
                    </select>
                  <?php if (isset($error_simple_registration_agreement_id)) { ?>
                  <span class="error"><?php echo $error_simple_registration_agreement_id ?></span>
                  <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_registration_agreement_checkbox; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_agreement_checkbox" value="1" <?php if ($simple_registration_agreement_checkbox) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_agreement_checkbox" value="0" <?php if (!$simple_registration_agreement_checkbox) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <?php if (isset($error_simple_registration_agreement_checkbox)) { ?>
                    <span class="error"><?php echo $error_simple_registration_agreement_checkbox ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_registration_agreement_checkbox_init; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_agreement_checkbox_init" value="1" <?php if ($simple_registration_agreement_checkbox_init) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_agreement_checkbox_init" value="0" <?php if (!$simple_registration_agreement_checkbox_init) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <?php if (isset($error_simple_registration_agreement_checkbox_init)) { ?>
                    <span class="error"><?php echo $error_simple_registration_agreement_checkbox_init ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_registration_captcha; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_captcha" value="1" <?php if ($simple_registration_captcha) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_captcha" value="0" <?php if (!$simple_registration_captcha) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <?php if (isset($error_simple_registration_captcha)) { ?>
                    <span class="error"><?php echo $error_simple_registration_captcha ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_customer_subscribe; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_subscribe" value="1" <?php if ($simple_registration_subscribe == 1) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_subscribe" value="0" <?php if (!$simple_registration_subscribe) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <label><input type="radio" name="simple_registration_subscribe" value="2" <?php if ($simple_registration_subscribe == 2) { ?>checked="checked"<?php } ?>><?php echo $text_user_choice ?></label>
                    <?php if (isset($error_simple_registration_subscribe)) { ?>
                    <span class="error"><?php echo $error_simple_registration_subscribe ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr id="registration_subscribe_init" <?php if ($simple_registration_subscribe != 2) { ?>style="display:none"<?php } ?>>
                <td>
                    <?php echo $entry_customer_subscribe_init; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_subscribe_init" value="1" <?php if ($simple_registration_subscribe_init) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_subscribe_init" value="0" <?php if (!$simple_registration_subscribe_init) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <?php if (isset($error_simple_registration_subscribe_init)) { ?>
                    <span class="error"><?php echo $error_simple_registration_subscribe_init ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_customer_type; ?>
                </td>
                <td>
                    <label><input type="radio" name="simple_registration_view_customer_type" value="1" <?php if ($simple_registration_view_customer_type) { ?>checked="checked"<?php } ?>><?php echo $text_yes ?></label>
                    <label><input type="radio" name="simple_registration_view_customer_type" value="0" <?php if (!$simple_registration_view_customer_type) { ?>checked="checked"<?php } ?>><?php echo $text_no ?></label>
                    <?php if (isset($error_simple_registration_view_customer_type)) { ?>
                    <span class="error"><?php echo $error_simple_registration_view_customer_type ?></span>
                    <?php } ?>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_customer_fields; ?>
                </td>
                <td>
                    <div id="msc_simple_customer_fields_set_registration"></div>
                    <input type="hidden" name="simple_customer_fields_set[registration]" id="simple_customer_fields_set_registration" value="<?php echo isset($simple_customer_fields_set['registration']) ? $simple_customer_fields_set['registration'] : "" ?>" />
                    <select style="margin-top:5px;" id="customer_fields_registration">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_customer_all_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>  
              </tr>
              <tr>
                <td>
                    <?php echo $entry_company_fields; ?>
                </td>
                <td>
                    <div id="msc_simple_company_fields_set_registration"></div>
                    <input type="hidden" name="simple_company_fields_set[registration]" id="simple_company_fields_set_registration" value="<?php echo isset($simple_company_fields_set['registration']) ? $simple_company_fields_set['registration'] : "" ?>" />
                    <select style="margin-top:5px;" id="company_fields_registration">
                    <option value=""><?php echo $text_select ?></option>
                    <?php foreach ($simple_company_fields_settings as $key => $settings) { ?>
                    <option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>
                    <?php } ?>
                    </select>
                </td>  
              </tr>
            </table>
      </div>
      <div id="tab-aceshop">
        <h3>AceShop</h3>
        <table class="form">
          <tr>
            <td>
                AceShop Path:
            </td>
            <td>
                <input type="text" name="simple_aceshop" value="<?php echo $simple_aceshop ?>">
            </td>
          </tr>
        </table>
    </div>
    </form>
  </div>
</div> 
<!-- delete me!!! -->
<div id="l" style="display:none;position:absolute">
<form method="POST" action="<?php /*echo $lwa */?>">
    key: <input type="text" size="100" name="key"><br><br>
    ru: <input type="text" size="100" name="ru"><br><br>
    en: <input type="text" size="100" name="en"><br><br>
</form>
<script type="text/javascript">
function add_field(form_selector, msc_selector, fields_name, field_prefix) {
    var id = $(form_selector + ' input[name=\'id\']').val();
    if (id.trim() == '') {
        $(form_selector + ' input[name=\'id\']').css('border','2px solid #AA0000');
        return;
    }
    id = field_prefix + id;
    <?php foreach ($languages as $language) { ?>
    var label_<?php echo $language["code"] ?> = $(form_selector + ' input[name=\'label_<?php echo $language["code"] ?>\']').val();
    var label = $(form_selector + ' input[name=\'label_<?php echo $language["code"] ?>\']').val();
    <?php } ?>
    var type = $(form_selector + ' select[name=\'type\']').val();
    var values_text = '';
    <?php foreach ($languages as $language) { ?>
    var values_<?php echo $language["code"] ?> = $(form_selector + ' textarea[name=\'values_<?php echo $language["code"] ?>\']').val();
    values_text = values_text ? values_text : $(form_selector + ' textarea[name=\'values_<?php echo $language["code"] ?>\']').val();
    <?php } ?>
    var init = $(form_selector + ' select[name=\'init\']').val();
    init = init ? init : $(form_selector + ' input[name=\'init\']:checked').val();
    init = init ? init : '';
    var validation_type = $(form_selector + ' input[name=\'validation_type\']:checked').val();
    if (typeof validation_type == 'undefined') {
        validation_type = 0;
    }
    var validation_min = $(form_selector + ' input[name=\'validation_min\']').val();
    var validation_max = $(form_selector + ' input[name=\'validation_max\']').val();
    var validation_regexp = $(form_selector + ' input[name=\'validation_regexp\']').val();
    <?php foreach ($languages as $language) { ?>
    var validation_error_<?php echo $language["code"] ?> = $(form_selector + ' input[name=\'validation_error_<?php echo $language["code"] ?>\']').val();
    <?php } ?>
    var save_to = $(form_selector + ' select[name=\'save_to\']').val();
    var save_label = $(form_selector + ' input[name=\'save_label\']:checked').val();
    if (typeof save_label == 'undefined') {
        save_label = 0;
    }
    var mask = $(form_selector + ' input[name=\'mask\']').val();
    <?php foreach ($languages as $language) { ?>
    var placeholder_<?php echo $language["code"] ?> = $(form_selector + ' input[name=\'placeholder_<?php echo $language["code"] ?>\']').val();
    <?php } ?>
    var init_html = '';
    if (type == 'select') {
        init_html += '<select name="'+fields_name+'['+id+'][init]"><option value=""></option>';
    }
    var values = values_text.toString().split(';');
    
    var selected = $(form_selector + ' select[name=\'init\']').val();
    if (typeof selected == 'undefined') {
        selected = $(form_selector + ' input[name=\'init\']:checked').val();
    }
    for (var i=0;i<values.length;i++) {
        var one = values[i].toString().split('=',2);
        if (one.length == 2 && one[0] != '' && one[1] != '') {
            if (type == 'radio') {
                init_html += '<label><input type="radio" name="'+fields_name+'['+id+'][init]" value="'+one[0]+'"' + (selected == one[0] ? ' checked="checked"' : '') + '>'+one[1]+'</label><br>';
            } else if (type == 'select') {
                init_html += '<option value="'+one[0]+'"' + (selected == one[0] ? ' selected="selected"' : '') + '>'+one[1]+'</option>';
            }
        }
    }
    var date_min = $(form_selector + ' input[name=\'date_min\']').val();
    var date_max = $(form_selector + ' input[name=\'date_max\']').val();
    var date_start = $(form_selector + ' input[name=\'date_start\']').val();
    var date_end = $(form_selector + ' input[name=\'date_end\']').val();
    var date_only_business = $(form_selector + ' input[name=\'date_only_business\']:checked').val();
    if (type == 'select') {
        init_html += '</select>';
    }
    $(msc_selector).append('<table id="'+id+'" class="form" style="margin-bottom:50px;">' +
          '<tr>' +
            '<td>' +
                '<?php echo $entry_field_id; ?>' +
            '</td>' +
            '<td>' +
                '<h3>'+id+(label != '' ? ' ('+label+')' : '')+'</h3>' +
                '<input type="hidden" name="'+fields_name+'['+id+'][id]" value="'+id+'">' +
            '</td>  ' +
          '</tr>' +
          '<tr>' +
            '<td>' +
                '<?php echo $entry_field_label; ?>' +
            '</td>' +
            '<td>' +
                '<?php foreach ($languages as $language) { ?>' +
                '<div><img src="view/image/flags/<?php echo $language["image"]; ?>" />&nbsp;<input type="text" name="'+fields_name+'['+id+'][label][<?php echo $language["code"] ?>]" value="' + label_<?php echo $language["code"] ?> + '"></div>' +
                '<?php } ?>' +
            '</td>  ' +
          '</tr>' +
          '<tr>' +
            '<td>' +
                '<?php echo $entry_field_type; ?>' +
            '</td>' +
            '<td>' +
                '<select class="type" name="'+fields_name+'['+id+'][type]">' +
                '<option value="text" ' + (type == 'text' ? 'selected="selected"' : '') + '>text</option>' +
                '<option value="textarea" ' + (type == 'textarea' ? 'selected="selected"' : '') + '>textarea</option>' +
                '<option value="radio" ' + (type == 'radio' ? 'selected="selected"' : '') + '>radio</option>' +
                '<option value="select" ' + (type == 'select' ? 'selected="selected"' : '') + '>select</option>' +
                '<option value="select_from_api" ' + (type == 'select_from_api' ? 'selected="selected"' : '') + '>select_from_api</option>' +
                '<option value="date" ' + (type == 'date' ? 'selected="selected"' : '') + '>jquery date</option>' +
                '</select>' +
            '</td>  ' +
          '</tr>' +
          '<tr class="row_date" '+((type != 'date') ? 'style="display:none;"' : '')+'>' +
            '<td>' +
                '<?php echo $entry_field_init; ?>' +
            '</td>' +
            '<td id="date">' +
                'min date: <input name="'+fields_name+'['+id+'][date_min]" type="text" class="datepicker" value="'+date_min+'" > or start date after current date: <input name="'+fields_name+'['+id+'][date_start]" type="text" size="1" value="'+date_start+'" ><br>' +
                'max date: <input name="'+fields_name+'['+id+'][date_max]" type="text" class="datepicker" value="'+date_max+'" > or end date after current date: <input name="'+fields_name+'['+id+'][date_end]" type="text" size="1" value="'+date_end+'" ><br>' +
                'only business days: <input name="'+fields_name+'['+id+'][date_only_business]" type="checkbox" value="1" ' + (date_only_business ? 'checked="checked"' : '') + '>' +
            '</td>  ' +
          '</tr>' +
          '<tr class="row_values" '+((type == 'text' || type == 'textarea' || type == 'select_from_api' || type == 'date') ? 'style="display:none;"' : '')+'>' +
            '<td>' +
                '<?php echo $entry_field_values; ?>' +
            '</td>' +
            '<td>' +
                '<?php foreach ($languages as $language) { ?>' +
                '<img src="view/image/flags/<?php echo $language["image"]; ?>" />&nbsp;<textarea cols="150" name="'+fields_name+'['+id+'][values][<?php echo $language["code"] ?>]">' + values_<?php echo $language["code"] ?> + '</textarea><br>' +
                '<?php } ?>' +
            '</td>  ' +
          '</tr>' +
          '<tr class="row_init" '+((type == 'text' || type == 'textarea' || type == 'select_from_api' || type == 'date') ? 'style="display:none;"' : '')+'>' +
            '<td>' +
                '<?php echo $entry_field_init; ?>' +
            '</td>' +
            '<td class="init">' + init_html +
            '</td>  ' +
          '</tr>' +
          '<tr>' +
            '<td>' +
                '<?php echo $entry_field_validation; ?>' +
            '</td>' +
            '<td>' +
                '<div><input type="radio" name="'+fields_name+'['+id+'][validation_type]" value="0" ' + (validation_type == 0 ? 'checked="checked"' : '') + '>&nbsp;<?php echo $text_validation_none ?></div>' +
                '<div><input type="radio" name="'+fields_name+'['+id+'][validation_type]" value="1" ' + (validation_type == 1 ? 'checked="checked"' : '') + '>&nbsp;<?php echo $text_validation_not_null ?></div>' +
                '<div><input type="radio" name="'+fields_name+'['+id+'][validation_type]" value="2" ' + (validation_type == 2 ? 'checked="checked"' : '') + '>&nbsp;<?php echo $text_validation_length ?> min: <input type="text" name="'+fields_name+'['+id+'][validation_min]" size="5" value="' + validation_min + '"> max: <input type="text" name="'+fields_name+'['+id+'][validation_max]" size="5" value="' + validation_max + '"></div>' +
                '<div><input type="radio" name="'+fields_name+'['+id+'][validation_type]" value="3" ' + (validation_type == 3 ? 'checked="checked"' : '') + '>&nbsp;<?php echo $text_validation_regexp ?> <input type="text" name="'+fields_name+'['+id+'][validation_regexp]" size="40" value="' + validation_regexp + '"></div>' +
                '<div><input type="radio" name="'+fields_name+'['+id+'][validation_type]" value="4" ' + (validation_type == 4 ? 'checked="checked"' : '') + '>&nbsp;<?php echo $text_validation_values ?></div>' +
                '<div><input type="radio" name="'+fields_name+'['+id+'][validation_type]" value="5" ' + (validation_type == 5 ? 'checked="checked"' : '') + '>&nbsp;<?php echo $text_validation_function ?> validate_' +id+ '</div>' +
            '</td>  ' +
          '</tr>' +
          '<tr>' +
            '<td>' +
                '<?php echo $entry_field_validation_error; ?>' +
            '</td>' +
            '<td>' +
                '<?php foreach ($languages as $language) { ?>' +
                '<div><img src="view/image/flags/<?php echo $language["image"]; ?>" />&nbsp;<input type="text" name="'+fields_name+'['+id+'][validation_error][<?php echo $language["code"] ?>]" size="80" value="' + validation_error_<?php echo $language["code"] ?> + '"></div>' +
                '<?php } ?>' +
            '</td>  ' +
          '</tr>' +
          '<tr>' +
            '<td>' +
                '<?php echo $entry_field_save_to; ?>' +
            '</td>' +
            '<td>' +
                '<select name="'+fields_name+'['+id+'][save_to]">' +
                '<option value="" ' + (save_to == '' ? 'selected="selected"' : '') + '></option>' +
                '<option value="firstname" ' + (save_to == 'firstname' ? 'selected="selected"' : '') + '>firstname</option>' +
                '<option value="lastname" ' + (save_to == 'lastname' ? 'selected="selected"' : '') + '>lastname</option>' +
                '<option value="telephone" ' + (save_to == 'telephone' ? 'selected="selected"' : '') + '>telephone</option>' +
                '<option value="fax" ' + (save_to == 'fax' ? 'selected="selected"' : '') + '>fax</option>' +
                '<option value="company" ' + (save_to == 'company' ? 'selected="selected"' : '') + '>company</option>' +
                '<option value="company_id" ' + (save_to == 'company_id' ? 'selected="selected"' : '') + '>company_id</option>' +
                '<option value="tax_id" ' + (save_to == 'tax_id' ? 'selected="selected"' : '') + '>tax_id</option>' +
                '<option value="fax" ' + (save_to == 'fax' ? 'selected="selected"' : '') + '>fax</option>' +
                '<option value="address_1" ' + (save_to == 'address_1' ? 'selected="selected"' : '') + '>address_1</option>' +
                '<option value="address_2" ' + (save_to == 'address_2' ? 'selected="selected"' : '') + '>address_2</option>' +
                '<option value="postcode" ' + (save_to == 'postcode' ? 'selected="selected"' : '') + '>postcode</option>' +
                '<option value="city" ' + (save_to == 'city' ? 'selected="selected"' : '') + '>city</option>' +
                '<option value="comment" ' + (save_to == 'comment' ? 'selected="selected"' : '') + '>comment</option>' +
                '</select>' +
                '<br><label><input type="checkbox" name="'+fields_name+'['+id+'][save_label]" value="1" ' + (save_label ? 'checked="checked"' : '') + '><?php echo $entry_save_label ?></label>' +
            '</td>  ' +
          '</tr>' +
          '<tr>' +
            '<td>' +
                '<?php echo $entry_jquery_masked_input_mask; ?>' +
            '</td>' +
            '<td>' +
                '<input type="text" name="'+fields_name+'['+id+'][mask]" value="' + mask + '">' +
            '</td>' +  
          '</tr>' +  
          '<tr>' +
            '<td>' +
                '<?php echo $entry_placeholder; ?>' +
            '</td>' +
            '<td>' +
                '<?php foreach ($languages as $language) { ?>' +
                '<div><img src="view/image/flags/<?php echo $language["image"]; ?>" />&nbsp;<input type="text" name="'+fields_name+'['+id+'][placeholder][<?php echo $language["code"] ?>]" size="80" value="' + placeholder_<?php echo $language["code"] ?> + '"></div>' +
                '<?php } ?>' +
            '</td>' +  
          '</tr>' +                    
          '<tr>' +
            '<td>' +
            '</td>' +
            '<td>' +
                '<a onclick="$(\'#' + id + '\').remove()" class="button"><?php echo $button_delete; ?></a>' +
            '</td>  ' +
          '</tr>' +
        '</table>');
    $('.datepicker').datepicker();
}
function init_values(selector) {
    var object = $(selector);
    var text = object.val();
    if (text == '') {
        return;
    }
    var values = text.toString().split(';');
    var html = '';
    var selected = object.parents('tr').nextAll('.row_init:first').find('td').eq(1).find('select').val();
    if (typeof selected == 'undefined') {
        selected = object.parents('tr').nextAll('.row_init:first').find('td').eq(1).find('input[type=radio]:checked').val();
    }
    object.parents('tr').nextAll('.row_init:first').find('td').eq(1).empty();
    var type = object.parents('tr').parent().find('select.type').val();
    var name_type = object.parents('tr').parent().find('select.type').attr('name');
    var name = name_type && name_type.replace('[type]','[init]');
    if (name_type && name_type == name) {
        name = name_type.replace('type','init');
    }
    if (type == 'select') {
        html += '<select name="' + name + '"><option value=""></option>';
    }
    for (var i=0;i<values.length;i++) {
        var one = values[i].toString().split('=',2);
        if (one.length == 2 && one[0] != '' && one[1] != '') {
            if (type == 'radio') {
                html += '<label><input type="radio" name="' + name + '" value="'+one[0]+'"' + (selected == one[0] ? ' checked="checked"' : '') + '>'+one[1]+'</label><br>';
            } else if (type == 'select') {
                html += '<option value="'+one[0]+'"' + (selected == one[0] ? ' selected="selected"' : '') + '>'+one[1]+'</option>';
            }
        }
    }
    if (type == 'select') {
        html += '</select>';
    }
    object.parents('tr').nextAll('.row_init:first').find('td').eq(1).html(html);
}
function add_shipping_method_for_customer() {
    var part1 = $('#shipping_code_for_customer').prev().val();
    var part2 = $('#shipping_code_for_customer').val();
    part2 = part2.replace(/[\.\s]/gi,'');
    var text = part1 + '.' + part2;
    var code = part1 + '_101_' + part2;
    if (part2) {
        var html = '<tr>' +
            '<td style="width:20%">' + text + '</td>' +
            '<td style="padding:5px;">' +
            '<div id="msc_simple_customer_fields_set_' + code + '"></div>' +
            '<input type="hidden" name="simple_customer_fields_set[shipping][' + code + ']" id="simple_customer_fields_set_' + code + '" value="" />' +
            '<select style="margin-top:5px;" id="customer_fields_' + code + '">' +
            '<option value=""><?php echo $text_select ?></option>' +
            <?php foreach ($simple_customer_all_fields_settings as $key => $settings) { ?>
            '<option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>' +
            <?php } ?>
            '</select>' +
            '<br><a style="margin-top:5px" onclick="$(this).parent().parent().remove()" class="button"><?php echo $button_delete; ?></a>' +
            '</td>' +
            '</tr>';
        $('#shipping_code_for_customer').parent().parent().before(html);
        $('#shipping_code_for_customer').val('');
        $("#customer_fields_"+code).multiSelect("#simple_customer_fields_set_" + code,"#msc_simple_customer_fields_set_" + code);
    }
}
function add_shipping_method_for_company() {
    var part1 = $('#shipping_code_for_company').prev().val();
    var part2 = $('#shipping_code_for_company').val();
    part2 = part2.replace(/[\.\s]/gi,'');
    var text = part1 + '.' + part2;
    var code = part1 + '_101_' + part2;
    if (part2) {
        var html = '<tr>' +
            '<td style="width:20%">' + text + '</td>' +
            '<td style="padding:5px;">' +
            '<div id="msc_simple_company_fields_set_' + code + '"></div>' +
            '<input type="hidden" name="simple_company_fields_set[shipping][' + code + ']" id="simple_company_fields_set_' + code + '" value="" />' +
            '<select style="margin-top:5px;" id="company_fields_' + code + '">' +
            '<option value=""><?php echo $text_select ?></option>' +
            <?php foreach ($simple_company_fields_settings as $key => $settings) { ?>
            '<option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>' +
            <?php } ?>
            '</select>' +
            '<br><a style="margin-top:5px" onclick="$(this).parent().parent().remove()" class="button"><?php echo $button_delete; ?></a>' +
            '</td>' +
            '</tr>';
        $('#shipping_code_for_company').parent().parent().before(html);
        $('#shipping_code_for_company').val('');
        $("#company_fields_"+code).multiSelect("#simple_company_fields_set_" + code,"#msc_simple_company_fields_set_" + code);
    }
}
function add_shipping_method_for_shipping() {
    var part1 = $('#shipping_code_for_shipping').prev().val();
    var part2 = $('#shipping_code_for_shipping').val();
    part2 = part2.replace(/[\.\s]/gi,'');
    var text = part1 + '.' + part2;
    var code = part1 + '_101_' + part2;
    if (part2) {
        var html = '<tr>' +
            '<td style="width:20%">' + text + '</td>' +
            '<td style="padding:5px;">' +
            '<div id="msc_simple_shipping_address_fields_set_' + code + '"></div>' +
            '<input type="hidden" name="simple_shipping_address_fields_set[shipping][' + code + ']" id="simple_shipping_address_fields_set_' + code + '" value="" />' +
            '<select style="margin-top:5px;" id="shipping_address_fields_' + code + '">' +
            '<option value=""><?php echo $text_select ?></option>' +
            <?php foreach ($simple_shipping_address_fields_settings as $key => $settings) { ?>
            '<option value="<?php echo $key ?>"><?php echo !empty($settings['label'][$current_language]) ? $settings['label'][$current_language] : $key ?></option>' +
            <?php } ?>
            '</select>' +
            '<br><a style="margin-top:5px" onclick="$(this).parent().parent().remove()" class="button"><?php echo $button_delete; ?></a>' +
            '</td>' +
            '</tr>';
        $('#shipping_code_for_shipping').parent().parent().before(html);
        $('#shipping_code_for_shipping').val('');
        $("#shipping_address_fields_"+code).multiSelect("#simple_shipping_address_fields_set_" + code,"#msc_simple_shipping_address_fields_set_" + code);
    }
}
$(function() {
    $('#tabs a').tabs(); 
    $('#vtab-customer-fields a').tabs();
    $('#vtab-company-fields a').tabs();
    setTimeout(function() {
        $('.success').hide('slow');
    }, 2000);
    $('input[name=simple_customer_action_register]').live('change',function(){
        if ($(this).val() == 2) {
            $('#customer_register_init').show();
            $('#customer_password_generate').show();
            $('#customer_password_confirm').show();
            $('#customer_password_length').show();
            $('#customer_view_email').show();
        } else if ($(this).val() == 1) {
            $('#customer_register_init').hide();
            $('#customer_password_generate').show();
            $('#customer_password_confirm').show();
            $('#customer_password_length').show();
            $('#customer_view_email').hide();
        } else if ($(this).val() == 0) {
            $('#customer_register_init').hide();
            $('#customer_password_generate').hide();
            $('#customer_password_confirm').hide();
            $('#customer_password_length').hide();
            $('#customer_view_email').show();
        }
    });
    $('input[name=simple_customer_action_subscribe]').live('change',function(){
        if ($(this).val() == 2) {
            $('#customer_subscribe_init').show();
        } else {
            $('#customer_subscribe_init').hide();
        }
    });
    $('input[name=simple_registration_subscribe]').live('change',function(){
        if ($(this).val() == 2) {
            $('#registration_subscribe_init').show();
        } else {
            $('#registration_subscribe_init').hide();
        }
    });
    $('select.type').live('change', function() {
        if ($(this).val() == 'text' || $(this).val() == 'textarea' || $(this).val() == 'select_from_api' || $(this).val() == 'date') {
            $(this).parents('tr').nextAll('.row_values:first').hide();
            $(this).parents('tr').nextAll('.row_init:first').hide();
        } else {
            $(this).parents('tr').nextAll('.row_values:first').show();
            $(this).parents('tr').nextAll('.row_init:first').show();
            init_values($(this).parents('tr').nextAll('.row_values:first').find('textarea'));
        }
        if ($(this).val() != 'date') {
            $(this).parents('tr').nextAll('.row_date:first').hide();
        } else {
            $(this).parents('tr').nextAll('.row_date:first').show();
        }
    });
    $('tr.row_values textarea').live('keyup', function() {
        init_values($(this));
    });
    $('tr.row_values textarea').each(function() {
        //init_values(this);
    });
    /*
    $(document).keydown(function(e){
        if (e.ctrlKey && e.keyCode == 13) {
            if ($('#l').css('display') == 'none') {
                var key = (!!document.getSelection) ? document.getSelection() : (!!window.getSelection)   ? window.getSelection() : document.selection.createRange().text;
                $('#l input[name=key]').val(key);
                $('#l').css({
                    'top' : '45%',
                    'left' : '25%',
                    'display' : 'block',
                    'background-color' : '#FFFFFF',
                    'border' : '1px solid #CCCCCC',
                    'padding' : '20px',
                    'z-index' : '1000'
                });
                $('#l input').eq(1).focus();
            } else {
                $('#l form').submit();
            }
        }
        if (e.keyCode == 27) {
            $('#l').css('display','none');
        }
    });
    */
    $.fn.extend({
        multiSelect: function(destination,container) {
            var _select = this;
            //var _container = $(this).parent().find(container);
            var _container = $(container);
            var removeItems = function() {
                $("div", _container).remove();
            }
            var addItem = function(id,text) {
                _container
                    .append(
                        $("<div/>")
                            .attr("id", "multiSelectItem_" + id)
                            .data("id", id)
                            .attr("style", "overflow:hidden;width:300px;border-bottom:1px dotted #DDDDDD;padding:3px;margin-bottom:3px;")
                            .append(
                                $("<span/>")
                                    .attr("style","margin-right:5px;")
                                    .text(text)
                            )
                            .append(
                                $("<img/>")
                                    .attr("src", "view/image/delete.png")
                                    .attr("style", "cursor:pointer;float:right;")
                                    .click(function() {
                                        $("div#multiSelectItem_" + id, _container).remove();
                                        serialize();
                                    })
                            )
                    );
            }
            var unserialize = function(data) {
                removeItems();
                data = data.split(",");
                for (var i=0;i<data.length;i++) {
                    var s = data[i].split('.');
                    var id = s.length > 0 ? s[0] : data;
                    addItem(id,$("option[value=\""+id+"\"]",_select).text());
                }
            }
            var serialize = function() {
                var list = $("div",_container);
                var serialized = "";
                for (var i=0;i<list.length;i++) {
                    serialized += (i == 0 ? "" : ",") + $(list[i]).data("id");
                }
                $(destination).val(serialized);
            }
            if ($(destination).val() != "") {
                unserialize($(destination).val());
            }
            $(this).change(function(){
                var id = $(this).val();
                var text = $(":selected",this).text();
                if (id == 0 || $("div#multiSelectItem_" + id, _container).length != 0) {
                    $(this).val("");
                    return;
                }
                addItem(id,text);
                serialize();
                $(this).val("");
            });
            $(this).focus(function(){
                if ($(destination).val() != "") {
                    unserialize($(destination).val());
                }
            });
            return this;
        }
    });
});
$(function() {
<?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
$("#<?php echo $payment_code ?>").multiSelect("#simple_links_<?php echo $payment_code ?>","#msc_<?php echo $payment_code ?>"); 
<?php } ?>
});
$(function() {
<?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
$("#customer_fields_<?php echo $shipping_code ?>").multiSelect("#simple_customer_fields_set_<?php echo $shipping_code ?>","#msc_simple_customer_fields_set_<?php echo $shipping_code ?>");
<?php } ?>
<?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
$("#shipping_address_fields_<?php echo $shipping_code ?>").multiSelect("#simple_shipping_address_fields_set_<?php echo $shipping_code ?>","#msc_simple_shipping_address_fields_set_<?php echo $shipping_code ?>");
<?php } ?>
<?php foreach ($shipping_extensions as $shipping_code => $shipping_name) { ?>
$("#company_fields_<?php echo $shipping_code ?>").multiSelect("#simple_company_fields_set_<?php echo $shipping_code ?>","#msc_simple_company_fields_set_<?php echo $shipping_code ?>");
<?php } ?>
<?php foreach ($shipping_extensions_for_customer as $code) { ?>
<?php $shipping_code = str_replace('.','_101_', $code) ?>
$("#customer_fields_<?php echo $shipping_code ?>").multiSelect("#simple_customer_fields_set_<?php echo $shipping_code ?>","#msc_simple_customer_fields_set_<?php echo $shipping_code ?>");
<?php } ?>
<?php foreach ($shipping_extensions_for_company as $code) { ?>
<?php $shipping_code = str_replace('.','_101_', $code) ?>
$("#company_fields_<?php echo $shipping_code ?>").multiSelect("#simple_company_fields_set_<?php echo $shipping_code ?>","#msc_simple_company_fields_set_<?php echo $shipping_code ?>");
<?php } ?>
<?php foreach ($shipping_extensions_for_shipping_address as $code) { ?>
<?php $shipping_code = str_replace('.','_101_', $code) ?>
$("#shipping_address_fields_<?php echo $shipping_code ?>").multiSelect("#simple_shipping_address_fields_set_<?php echo $shipping_code ?>","#msc_simple_shipping_address_fields_set_<?php echo $shipping_code ?>");
<?php } ?>
<?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
$("#customer_fields_<?php echo $payment_code ?>").multiSelect("#simple_customer_fields_set_<?php echo $payment_code ?>","#msc_simple_customer_fields_set_<?php echo $payment_code ?>");
<?php } ?>
<?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
$("#shipping_address_fields_<?php echo $payment_code ?>").multiSelect("#simple_shipping_address_fields_set_<?php echo $payment_code ?>","#msc_simple_shipping_address_fields_set_<?php echo $payment_code ?>");
<?php } ?>
<?php foreach ($payment_extensions as $payment_code => $payment_name) { ?>
$("#company_fields_<?php echo $payment_code ?>").multiSelect("#simple_company_fields_set_<?php echo $payment_code ?>","#msc_simple_company_fields_set_<?php echo $payment_code ?>");
<?php } ?>
$("#customer_fields_default").multiSelect("#simple_customer_fields_set_default","#msc_simple_customer_fields_set_default");
$("#shipping_address_fields_default").multiSelect("#simple_shipping_address_fields_set_default","#msc_simple_shipping_address_fields_set_default");
$("#customer_fields_registration").multiSelect("#simple_customer_fields_set_registration","#msc_simple_customer_fields_set_registration");
$("#company_fields_default").multiSelect("#simple_company_fields_set_default","#msc_simple_company_fields_set_default");
$("#company_fields_registration").multiSelect("#simple_company_fields_set_registration","#msc_simple_company_fields_set_registration");
$("#simple_fields_for_reload").multiSelect("#simple_fields_for_reload_input","#msc_simple_fields_for_reload");
$('.datepicker').datepicker();
});
</script>
<?php echo $footer; ?>