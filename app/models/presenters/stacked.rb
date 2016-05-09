module Presenters
  class Stacked < Base

    def data
      return @dataset unless @dataset.nil?
      @dataset = {}
      labels.each do |label|
        @data.select{|e| e['label'] == label}.each do |elements|
          elements.select{|k,v| k != 'label'}.each do |key,value|
            @dataset[key] = [] if @dataset[key].nil?
            @dataset[key] << value
          end
        end
      end
      @dataset
    end

    def labels
       @labels ||= @data.map{|e| e['label']}.uniq
    end

    def dataset_option_sring label, values
      "{
          label: '#{label}',
          backgroundColor: '\##{colors_per_element[label]}',
          borderColor: 'rgba(255,99,132,1)',
          borderWidth: 1,
          hoverBackgroundColor: '\##{colors_per_element[label]}',
          hoverBorderColor: 'rgba(0,0,0,0)',
          data: [#{values.join(',')}]
      }"
    end

    def datasets_string
      data.map{|label,values|
        dataset_option_sring(label, values)
      }.join(",")
    end

    def colors_per_element
      return @colors_per_element unless @colors_per_element.nil?
      @colors_per_element = {}
      data.each do |k,v|
        @colors_per_element[k] = Digest::MD5.hexdigest(k)[0..2]
      end
      @colors_per_element
    end
  end
end
