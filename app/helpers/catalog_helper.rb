module CatalogHelper
  include Blacklight::CatalogHelperBehavior

  def render_format_field_facet value
    t "mxd_type_labels.#{value}"
  end

  def render_source_field_facet value
    t "source_labels.#{value}"
  end

  def render_format_field_index args
 
    t "new_subtypes.#{args[:document]['format']}"
  end
end
