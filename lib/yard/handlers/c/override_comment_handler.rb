# Parses comments
class YARD::Handlers::C::OverrideCommentHandler < YARD::Handlers::C::Base
  handles %r{.}
  statement_class Comment
  
  process do
    return if statement.overrides.empty?
    statement.overrides.each do |type, name|
      override_comments << [name, statement]
      obj = nil
      case type
      when :class
        obj = YARD::CodeObjects::ClassObject.new(:root, name)
      when :module
        obj = YARD::CodeObjects::ModuleObject.new(:root, name)
      end
      register_docstring(obj, statement.source, statement) if obj
    end
  end
end
