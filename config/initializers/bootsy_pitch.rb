Casein::CaseinHelper.class_eval do
  def casein_bootsy_area form, obj, attribute, options = {}
    casein_form_tag_wrapper(form.bootsy_area(attribute, strip_casein_options(options_hash_with_merged_classes(options, 'form-control'))), form, obj, attribute, options).html_safe
  end
end
