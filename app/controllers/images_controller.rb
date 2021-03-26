class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def index

  end

  def create
    handler = VisionHandler.new
    uploader = ImageUploader.new  

    image = Image.new
    image.file = params[:file]
    image.save

    response = handler.detect_objects(image.file.path)

    response.each do |description|
      image.labels.create(description: description)
    end

    respond_to do |format|
      format.json { render json: {url: image_url(image.id)} }
    end
  end

  def show
    @image = Image.find(params[:id])
    @items = LabelSearcher.new(@image.labels).search
    @image.labels.each do |label|
      label_items = @items.select { |item| item.label_id == label.id }
      next if label_items.size == 0
      average_price = label_items.map { |x| x.price }.sum / label_items.size 
      label.update(average_price: average_price)
    end

    average_prices = @image.labels.pluck(:average_price)
    @sum_price = average_prices.size > 0 ? average_prices.inject(0){|sum,x| sum.to_i + x.to_i } : 0
  end  
end
