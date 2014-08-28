# -*- encoding : utf-8 -*-
#
class CatalogController < ApplicationController  

  include Blacklight::Catalog

  layout 'blacklight'

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => '/ddf_publ',
      :rows => 15 
    }
    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select' 
    # items to show per page, each number in the array represent another option to choose from.
    config.per_page = [10,20,50,100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    config.default_document_solr_params = {
     :qt => '/ddf_publ_document',
      ## These are hard-coded in the blacklight 'document' requestHandler
      # :fl => '*',
      # :rows => 1
      # :q => '{!raw f=id v=$id}' 
    }
    # solr field configuration for search results/index views
    config.index.title_field = 'title_ts'
    config.index.display_type_field = 'format'
    config.index.source_id = 'source_ss'
    config.index.affiliation_field = 'affiliation_ts'

    # solr field configuration for document/show views
    config.show.title_field = 'title_ts'
    config.show.display_type_field = 'format'
    config.show.affiliation_field = 'affiliation_ts'
    config.show.source_id = 'source_ss'
    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar
    config.add_facet_field 'format', :label => 'Type', :helper_method => :render_format_field_facet
    config.add_facet_field 'pub_date_tsort', :label => 'Publication Year', :range => true
    config.add_facet_field 'source_ss', :label => 'Research Institution', :helper_method => :render_source_field_facet, :limit => 10
    config.add_facet_field 'author_facet', :label => 'Author', :limit => 10
    config.add_facet_field 'keywords_facet', :label => 'Research Area', :limit => 10
    config.add_facet_field 'journal_title_facet', :label => 'Journal Title', :limit => 10

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!
    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'author_ts', :label => 'Authors', :separator => ' ; '
    config.add_index_field 'format', :label => 'Type', :helper_method => :render_format_field_index
    config.add_index_field 'journal_title_ts', :label => 'Published in', :helper_method => :render_journal_info
    config.add_index_field 'abstract_ts', :label => 'Abstract', :helper_method => :snip_abstract
    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'author_ts', :label => 'Authors', :separator => ' ; '
    config.add_show_field 'format', :label => 'Type', :helper_method => :render_format_field_index
    config.add_show_field 'journal_title_ts', :label => 'Published in', :helper_method => :render_journal_info
    config.add_show_field 'abstract_ts', :label => 'Abstract', :helper_method => :snip_abstract
    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 
    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    config.add_search_field 'all_fields', :label => 'Title'
    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field  'score desc, id desc', :label => 'relevance' 
  end
end 
