; (quoted_regexp) @regex.outer
;
; (match_regexp) @regex.outer
;
; (for_statement (block) @loop.inner) @loop.outer
; (loop_statement (block) @loop.inner) @loop.outer
;
;
; ; (subroutine_declaration_statement (block) @function.inner) @function.outer
;
; (conditional_statement (block) @conditional.inner) @conditional.outer
;
; ; postfix_conditional_expression
;
; ; (block) @scope
;
; ; https://github.com/meain/evil-textobj-tree-sitter/blob/a19ab9d89a00f4a04420f9b5d61b66f04fea5261/treesit-queries/perl/textobjects.scm#L4
; (subroutine_declaration_statement
;   body: (_) @function.inner) @function.outer
; (anonymous_subroutine_expression
;   body: (_) @function.inner) @function.outer
;
; (package_statement) @class.outer
; (package_statement
;   (block) @class.inner)
;
; (list_expression
;   (_) @parameter.inner)
;
; (comment) @comment.outer
; (pod) @comment.outer
