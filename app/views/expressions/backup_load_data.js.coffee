imageSearch.execute( '<%= escape_javascript(@query) %>' );


$('#definitions').html('<div><b>Definitions</b></div>')

'<% @definitions.each do |definition| %>'
$('#definitions').append('<%= j(
      render(:partial => "definition", :locals => {:text => definition, :element_class => "definition"} )
      ) %>')

'<%end%>'


if !$.trim($('input#expression_name')[1].value)
# if empty
  $('input#expression_name').attr('value','<%= @query %>')
else
  $('#suggested_name').append('<div class="name"><%= @query %></div>')


#$('input#image_url[type=hidden]').attr('value', '' )



$('#examples').html('<div><b>Examples</b></div>')

'<% @examples.each do |example| %>'
$('#examples').append('<%= j(
      render(:partial => "definition", :locals => {:text => example, :element_class => "example"} )
      ) %>')

'<%end%>'



$('#synonyms').html('<div><b>Synonyms</b></div>')

'<% @synonyms.each do |synonym| %>'
$('#synonyms').append('<%= j(
      render(:partial => "definition", :locals => {:text => synonym, :element_class => "synonym"} )
      ) %>')

'<%end%>'


$('#data_loading').hide()


