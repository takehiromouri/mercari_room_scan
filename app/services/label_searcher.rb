class LabelSearcher
  def initialize(labels)
    @labels = labels
    client = Algolia::Search::Client.create(ENV['ALGOLIA_APPLICATION_ID'], ENV['ALGOLIA_API_KEY'])
    @al_index = client.init_index('items-dev.20170801')
  end

  def search    
    items = []    

    @labels.each do |label|      
      response = @al_index.search(label.description)
      response[:hits].each do |item|
        items << Item.new(item[:price], item[:name], item[:objectID], label.id)
      end
    end

    return items
  end
end

Item = Struct.new(:price, :name, :item_id, :label_id)