module CatalogHelper
  include Blacklight::CatalogHelperBehavior

  def render_format_field_facet value
    t "mxd_type_labels.#{value}"
  end

  def render_source_field_facet value
    t "source_labels.#{value}"
  end

  def render_source_field args
    args[:document]['source_ss'].collect {|s| t "source_labels.#{s}"}.join ' ; '
  end

  def render_format_field_index args
    t "mxd_type_labels.#{args[:document]['format_orig_s']}"
  end

  def get_backlink_origin link
    case link
    when /^https?:\/\/orbit.dtu.dk/
      'orbit'
    when /^https?:\/\/pure.au.dk/
      'rdb_au'
    when /^https?:\/\/forskning.ku.dk/
      'rdb_ku'
    when /^https?:\/\/pure.itu.dk/
      'rdb_itu'
    when /^https?:\/\/research.cbs.dk/
      'rdb_cbs'
    when /^https?:\/\/vbn.aau.dk/
      'rdb_vbn'
    when /^https?:\/\/rucforsk.ruc.dk/
      'rdb_ruc'
    when /^https?:\/\/findresearcher.sdu.dk/
      'rdb_sdu'
    end
  end
end
