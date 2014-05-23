# -*- encoding : utf-8 -*-
#
class CatalogController < ApplicationController  
  include Blacklight::Marc::Catalog

  include Blacklight::Catalog

  layout 'blacklight'

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 15 
    }
    
    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select' 
    
    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}' 
    #}

    # solr field configuration for search results/index views
   
    #config.index.title_field = 'title'
    #config.index.display_type_field = 'format'

    # solr field configuration for document/show views
    #config.show.title_field = 'title_display'
    #config.show.display_type_field = 'format'

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
    #config.add_facet_field 'format', :label => 'Format'
    config.add_facet_field 'title', :label => 'Title', :single => true
    config.add_facet_field 'journal_title', :label => 'Journal_title', :single => true
    config.add_facet_field 'author', :label => 'Author', :limit => 20 
    config.add_facet_field 'abstract', :label => 'Abstract', :single => true 
    config.add_facet_field 'vol', :label => 'Vol', :limit => true
    config.add_facet_field 'doi', :label => 'doi', :limit => true
    config.add_facet_field 'issue', :label => 'Issue', :limit =>true
    config.add_facet_field 'issn', :label => 'ISSN', :limit => true
    config.add_facet_field 'pages', :label => 'Pages', :limit => true
    config.add_facet_field 'year', :label => 'year', :limit => true 

 
    
    #*my own* I wanted to make  a new search field- it failed   
    #config.add_facet_field 'publisher', :label => 'Publisher', :limit => 10
    #, :limit => true
    #config.add_facet_field 'example_pivot_field', :label => 'Pivot Field', :pivot => ['format', 'language_facet']
    #config.add_facet_field 'library', :label => 'library', :limit => true
    #config.add_facet_field 'year', :label => 'Year', :query => {
    #:years_5 => { :label => 'within 5 Years', :fq => "year:[#{Time.now.year - 5 } TO *]" },
       #:years_10 => { :label => 'within 10 Years', :fq => "year:[#{Time.now.year - 10 } TO *]" },
       #:years_25 => { :label => 'within 25 Years', :fq => "year:[#{Time.now.year - 25 } TO *]" }
    #}
  
    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'title', :label => 'Title'
    config.add_index_field 'journal_title', :label => 'Journal_title'
    config.add_index_field 'author', :label => 'Author'
    config.add_index_field 'affiliation', :label => 'Affiliation'
    config.add_index_field 'abstract', :label => 'Abstract'
    config.add_index_field 'year', :label => 'Year'
    config.add_index_field 'issn', :label => 'ISSN'
    config.add_index_field 'vol', :label => 'Vol'
    config.add_index_field 'issue', :label => 'Issue'
    config.add_index_field 'pages', :label => 'Pages'
    config.add_index_field 'doi', :label => 'doi'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'title', :label => 'Title'
    config.add_show_field 'journal_title', :label => 'Journal_title'
    config.add_show_field 'author', :label => 'Author'
    config.add_show_field 'affiliation', :label => 'Affiliation'
    config.add_show_field 'abstract', :label => 'Abstract'
    config.add_show_field 'year', :label => 'Year'
    config.add_show_field 'issn', :label => 'ISSN'
    config.add_show_field 'vol', :label => 'Vol'
    config.add_show_field 'issue', :label => 'Issue'
    config.add_show_field 'pages', :label => 'Pages'
    config.add_show_field 'doi', :label => 'doi'
    #config.add_show_field 'lc_callnum_display', :label => 'Call number'
    #config.add_show_field 'isbn_t', :label => 'ISBN'
    #config.add_show_field 'publisher', :label => 'Publisher'

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
    
    config.add_search_field 'all_fields', :label => 'All Fields'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
    
    #config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params. 
      #field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      #field.solr_local_parameters = { 
        #:qf => '$title_qf',
        #:pf => '$title_pf'
      #}
    #end
    
    #config.add_search_field('journal_title') do |field|
    
    #field.solr_parameters = { :'spellcheck.dictionary' => 'journal_title'}
    #field.solr_local_parameters = {
	    
	   # :qf => '$journal_title_qf',
	    #:pf => '$journal_title_pf'
    #}
   #end
    
    #config.add_search_field('author') do |field|
     # field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
      #field.solr_local_parameters = { 
       # :qf => '$author_qf',
        #:pf => '$author_pf'
      #}
    #end
    
    #config.add_search_field('affiliation') do |field|
    #field.solr_parameters = { :'spellcheck.dictionary' => 'affiliation' }
    #field.solr_local_parameters = {
	 #:qf => '$affiliation_qf',
	 #:pf => '$affiliation_pf'   
    #}
    #end
    
    #config.add_search_field('abstract') do |field|
    #field.solr_parameters = { :'spellcheck.dictionary' => 'abstract' }
    #field.solr_local_parameters = {
	    
	    #:qf => '$abstract_qf',
	    #:pf => '$abstract_pf'
    #}
    #end
    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as 
    # config[:default_solr_parameters][:qt], so isn't actually neccesary. 
    #config.add_search_field('year') do |field|
     # field.solr_parameters = { :'spellcheck.dictionary' => 'year' }
      #field.qt = 'search'
      #field.solr_local_parameters = { 
       # :qf => '$year_qf',
        #:pf => '$year_pf'
      #}
    #end
    
    #config.add_search_field('issn') do |field|
     #field.solr_parameters = { :'spellcheck.dictionary' => 'issn' }
     #field.qt = 'search'
     #field.solr_local_parameters = {
	     # :qf => '$issn_qf',
	     # :pf => '$issn_pf'
     # }
    #end
    
    #config.add_search_field('vol') do |field|
    #field.solr_parameters = { :'spellcheck.dictionary' => 'vol' }
    #field.qt = 'search'
    #field.solr_local_parameters = {
	    #:qf => '$vol_qf',
	    #:pf => '$vol_pf'
   # }
    #end
    
    #config.add_show_field 'isbn_t', :label => 'ISBN'
    
    #config.add_search_field('issue') do |field|
    #field.solr_parameters = { :'spellcheck.dictionary' => 'issue' }
    #field.qt = 'search'
    #field.solr_local_parameters = {
	 # :qf => '$issue_qf',
	#:pf => '$issue_pf'  
    #}
    #end
    
    
   #config.add_search_field('pages') do |field|
   #field.solr_parameters = { :'spellcheck.dictionary' => 'pages'}
   #field.qt = 'search'
   #field.solr_local_parameters = {
	#:qf => '$pages_qf',
	#:pf => '$pages_pf' 
	   
   #}
   #end
    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    #config.add_sort_field 'score desc, year_sort desc, title_sort asc', :label => 'relevance'
    #config.add_sort_field 'year_sort desc, title_sort asc', :label => 'year'
    #config.add_sort_field 'author_sort asc, title_sort asc', :label => 'author'
    #config.add_sort_field 'title_sort asc, year_sort desc', :label => 'title'
    #config.add_sort_field 'publisher_sort asc, pub_date_sort desc, title_sort asc', :label => 'jour'
    #config.add_sort_field 'language_sort asc, author_sort asc', :label => 'language'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    #config.spell_max = 5
  end

end 
