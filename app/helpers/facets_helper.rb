module FacetsHelper
  include Blacklight::FacetsHelperBehavior

  def render_facet_count num, options = {}
    super number_with_delimiter(num), options
  end
end
