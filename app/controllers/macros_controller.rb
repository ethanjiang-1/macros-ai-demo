class MacrosController < ApplicationController
  def display_form
    render({:template => "macros_templates/blank_form"})
  end

  def do_magic
    @description = params.fetch("description_param")
    @image = DataURI.convert(params["image_param"])

    render({ template: "macros_templates/results" })
  end
end
