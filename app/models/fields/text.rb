module Fields
  class Text < Base
    def form_field
      "<input name='dynamic_fields[#{@dynamic_field.key}]' value=''>"
    end
  end
end
