module ApplicationHelper
  def full_title page_title =""
    base_title = t "app_name"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def link_to_remove_fields f
    f.hidden_field(:_destroy) + link_to(raw("<span class='glyphicon glyphicon-remove'></span>"),
      "#", onclick: "remove_fields(this)")
  end

  def link_to_add_fields f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to raw("<span class='glyphicon glyphicon-plus-sign'></span> #{t :add_answer}"),
      "#", onclick: "add_fields(this, \"#{association}\",
        \"#{escape_javascript(fields)}\")", class: "btn btn-default btn-block"
  end
end
