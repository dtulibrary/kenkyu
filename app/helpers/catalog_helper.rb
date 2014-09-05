module CatalogHelper
  include Blacklight::CatalogHelperBehavior

  def render_format_field_facet value
    t "mxd_type_labels.#{value}"
  end

  def render_source_field_facet value
    t "source_labels.#{value}"
  end

  def render_source_field args
    case t "source_labels.#{args[:document]['source_ss']}"
   when /["Orbit"]/
    'Technical University of Denmark'
   when /["Rdb Ku"]/
    'University of Copenhagen'
   when /["Rdb Itu"]/
    'IT University of Copenhagen'
   when /["Rdb Au"]/
    'Aarhus University'
   when /["Rdb Cbs"]/
    'Copenhagen Business School'
   when /["Rdb Ruc"]/
    'Roskilde University'
   when /["Rdb Sdu"]/
    'University of Southern Denmark'
   when /["Rdb Vbn"]/
    'Aalborg University'
   end
  end

  def render_format_field_index args
   t "new_subtypes.#{args[:document]['format']}"
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
