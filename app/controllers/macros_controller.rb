class MacrosController < ApplicationController
  def display_form
    render({:template => "macros_templates/blank_form"})
  end

  def do_magic
    if params["description_param"].blank? || params["image_param"].blank?
      render plain: "Error: description and image are required", status: :unprocessable_entity
      return
    end

    @description = params.fetch("description_param")
    @image = DataURI.convert(params["image_param"])


    chat = OpenAI::Chat.new
    chat.system("You are an expert nutritionist. Estimate the macronutrients carbohydrates, protein, and fat in grams, as well as a total calories count in kcal. Additionally, give a short note explaining how you arrived at the values in no more than 3 sentences. The values should be accurate and based on the food item description and image provided. Please ensure that the total calories are calculated based on the macronutrient breakdown.")
    chat.schema = '{"name": "nutrition_values","strict": true,"schema": {"type": "object","properties": {  "fat": {    "type": "number",    "description": "The amount of fat in grams."  },  "protein": {    "type": "number",    "description": "The amount of protein in grams."  },  "carbs": {    "type": "number",    "description": "The amount of carbohydrates in grams."  },  "total_calories": {    "type": "number",    "description": "The total calories calculated based on fat, protein, and carbohydrates."  }},"required": [  "fat",  "protein",  "carbs",  "total_calories"],"additionalProperties": false}}'
    chat.model = "o4-mini"
    chat.user("I have a food item with the following description: #{@description}. The image is: #{@image}. Please provide the macronutrient breakdown.")
    @response = chat.assistant!

    render({ template: "macros_templates/results" })
  end
end
