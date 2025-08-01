" https://raw.githubusercontent.com/dlam26/xqueryvim/master/autoload/xquerycomplete.vim
" XQuery completion script
" Language:     XQuery
" Maintainer:   David Lam <dlam@dlam.me>
" Created:      2010 May 27
" Last Change:  2012 Oct 8
"
" Notes:
"   Completes W3C XQuery 'fn' functions, types and keywords. 
"
"   Also completes all the MarkLogic functions I could find at...
"   http://community.marklogic.com/pubs/5.0/apidocs/All.html
"
"   Updated with functx and new MarkLogic 5.0 functions by Steve Spigarelli!
"
" Usage:
"   Generally, just start by typing it's namespace and then <CTRL-x><CTRL-o>
"
"        fn<CTRL-x><CTRL-o>
"           ->  list of functions in the 'fn' namespace
"
"        fn:doc<CTRL-x><CTRL-o>
"           ->  fn:doc(
"               fn:doc-available(
"               fn:document-uri(
"
"        xs<CTRL-x><CTRL-o>
"           ->  list of all xquery types
"
"        decl<CTRL-x><CTRL-o>
"           ->  declare
"               declare function
"               declare namespace
"               declare option
"               declare default
"
"
"   :h complete-functions
"   :h omnifunc
"   :h filetype-plugin-on

 
if exists("b:did_xqueryomnicomplete")
    "finish
    delfunction xquerycomplete#CompleteXQuery
endif
let b:did_xqueryomnicomplete = 1
 
function! xquerycomplete#CompleteXQuery(findstart, base) 

  if a:findstart
	" locate the start of the word
	let line = getline('.')
	let start = col('.') - 1
	let curline = line('.')
	let compl_begin = col('.') - 2
    
    " 5/29/2010   \|  joins two regex branches!         :h pattern
	while start >= 0 && line[start - 1] =~ '\k\|:\|\-\|&'
		let start -= 1
	endwhile
	let b:compl_context = getline('.')[0:compl_begin]

	return start
  else

    " let admin_api_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/AdminLibrary.html
    let admin_api_functions = [
        \ 'appserver-add-namespace',
        \ 'appserver-add-request-blackout',
        \ 'appserver-add-schema',
        \ 'appserver-copy',
        \ 'appserver-delete',
        \ 'appserver-delete-namespace',
        \ 'appserver-delete-request-blackout',
        \ 'appserver-delete-schema',
        \ 'appserver-exists',
        \ 'appserver-get-address',
        \ 'appserver-get-authentication',
        \ 'appserver-get-backlog',
        \ 'appserver-get-collation',
        \ 'appserver-get-compute-content-length',
        \ 'appserver-get-concurrent-request-limit',
        \ 'appserver-get-database',
        \ 'appserver-get-debug-allow',
        \ 'appserver-get-default-time-limit',
        \ 'appserver-get-default-user',
        \ 'appserver-get-default-xquery-version',
        \ 'appserver-get-display-last-login',
        \ 'appserver-get-enabled',
        \ 'appserver-get-error-handler',
        \ 'appserver-get-group-id',
        \ 'appserver-get-host-ids',
        \ 'appserver-get-id',
        \ 'appserver-get-keep-alive-timeout',
        \ 'appserver-get-last-login',
        \ 'appserver-get-log-errors',
        \ 'appserver-get-max-time-limit',
        \ 'appserver-get-modules-database',
        \ 'appserver-get-multi-version-concurrency-control',
        \ 'appserver-get-name',
        \ 'appserver-get-namespaces',
        \ 'appserver-get-output-byte-order-mark',
        \ 'appserver-get-output-cdata-section-localname',
        \ 'appserver-get-output-cdata-section-namespace-uri',
        \ 'appserver-get-output-doctype-public',
        \ 'appserver-get-output-doctype-system',
        \ 'appserver-get-output-encoding',
        \ 'appserver-get-output-escape-uri-attributes',
        \ 'appserver-get-output-include-content-type',
        \ 'appserver-get-output-include-default-attributes',
        \ 'appserver-get-output-indent',
        \ 'appserver-get-output-indent-untyped',
        \ 'appserver-get-output-media-type',
        \ 'appserver-get-output-method',
        \ 'appserver-get-output-normalization-form',
        \ 'appserver-get-output-omit-xml-declaration',
        \ 'appserver-get-output-sgml-character-entities',
        \ 'appserver-get-output-standalone',
        \ 'appserver-get-output-undeclare-prefixes',
        \ 'appserver-get-output-version',
        \ 'appserver-get-port',
        \ 'appserver-get-pre-commit-trigger-depth',
        \ 'appserver-get-pre-commit-trigger-limit',
        \ 'appserver-get-privilege',
        \ 'appserver-get-profile-allow',
        \ 'appserver-get-request-blackouts',
        \ 'appserver-get-request-timeout',
        \ 'appserver-get-root',
        \ 'appserver-get-schemas',
        \ 'appserver-get-session-timeout',
        \ 'appserver-get-ssl-allow-sslv3',
        \ 'appserver-get-ssl-allow-tls',
        \ 'appserver-get-ssl-certificate-template',
        \ 'appserver-get-ssl-ciphers',
        \ 'appserver-get-ssl-client-certificate-authorities',
        \ 'appserver-get-ssl-hostname',
        \ 'appserver-get-ssl-require-client-certificate',
        \ 'appserver-get-static-expires',
        \ 'appserver-get-threads',
        \ 'appserver-get-type',
        \ 'appserver-get-url-rewriter',
        \ 'appserver-one-time-request-blackout',
        \ 'appserver-recurring-request-blackout',
        \ 'appserver-set-address',
        \ 'appserver-set-authentication',
        \ 'appserver-set-backlog',
        \ 'appserver-set-collation',
        \ 'appserver-set-compute-content-length',
        \ 'appserver-set-concurrent-request-limit',
        \ 'appserver-set-database',
        \ 'appserver-set-debug-allow',
        \ 'appserver-set-default-time-limit',
        \ 'appserver-set-default-user',
        \ 'appserver-set-default-xquery-version',
        \ 'appserver-set-display-last-login',
        \ 'appserver-set-enabled',
        \ 'appserver-set-error-handler',
        \ 'appserver-set-keep-alive-timeout',
        \ 'appserver-set-last-login',
        \ 'appserver-set-log-errors',
        \ 'appserver-set-max-time-limit',
        \ 'appserver-set-modules-database',
        \ 'appserver-set-multi-version-concurrency-control',
        \ 'appserver-set-name',
        \ 'appserver-set-output-byte-order-mark',
        \ 'appserver-set-output-cdata-section-localname',
        \ 'appserver-set-output-cdata-section-namespace-uri',
        \ 'appserver-set-output-doctype-public',
        \ 'appserver-set-output-doctype-system',
        \ 'appserver-set-output-encoding',
        \ 'appserver-set-output-escape-uri-attributes',
        \ 'appserver-set-output-include-content-type',
        \ 'appserver-set-output-include-default-attributes',
        \ 'appserver-set-output-indent',
        \ 'appserver-set-output-indent-untyped',
        \ 'appserver-set-output-media-type',
        \ 'appserver-set-output-method',
        \ 'appserver-set-output-normalization-form',
        \ 'appserver-set-output-omit-xml-declaration',
        \ 'appserver-set-output-sgml-character-entities',
        \ 'appserver-set-output-standalone',
        \ 'appserver-set-output-undeclare-prefixes',
        \ 'appserver-set-output-version',
        \ 'appserver-set-port',
        \ 'appserver-set-pre-commit-trigger-depth',
        \ 'appserver-set-pre-commit-trigger-limit',
        \ 'appserver-set-privilege',
        \ 'appserver-set-profile-allow',
        \ 'appserver-set-request-timeout',
        \ 'appserver-set-root',
        \ 'appserver-set-session-timeout',
        \ 'appserver-set-ssl-allow-sslv3',
        \ 'appserver-set-ssl-allow-tls',
        \ 'appserver-set-ssl-certificate-template',
        \ 'appserver-set-ssl-ciphers',
        \ 'appserver-set-ssl-client-certificate-authorities',
        \ 'appserver-set-ssl-hostname',
        \ 'appserver-set-ssl-require-client-certificate',
        \ 'appserver-set-static-expires',
        \ 'appserver-set-threads',
        \ 'appserver-set-url-rewriter',
        \ 'cluster-get-foreign-cluster-id',
        \ 'cluster-get-foreign-cluster-ids',
        \ 'cluster-get-foreign-master-database',
        \ 'cluster-get-foreign-replica-databases',
        \ 'cluster-get-id',
        \ 'cluster-get-name',
        \ 'cluster-get-xdqp-bootstrap-hosts',
        \ 'cluster-get-xdqp-ssl-certificate',
        \ 'cluster-get-xdqp-ssl-private-key',
        \ 'cluster-set-name',
        \ 'cluster-set-xdqp-bootstrap-hosts',
        \ 'cluster-set-xdqp-ssl-certificate',
        \ 'database-add-backup',
        \ 'database-add-element-attribute-word-lexicon',
        \ 'database-add-element-word-lexicon',
        \ 'database-add-element-word-query-through',
        \ 'database-add-field',
        \ 'database-add-field-excluded-element',
        \ 'database-add-field-included-element',
        \ 'database-add-field-word-lexicon',
        \ 'database-add-foreign-replicas',
        \ 'database-add-fragment-parent',
        \ 'database-add-fragment-root',
        \ 'database-add-geospatial-element-attribute-pair-index',
        \ 'database-add-geospatial-element-child-index',
        \ 'database-add-geospatial-element-index',
        \ 'database-add-geospatial-element-pair-index',
        \ 'database-add-merge-blackout',
        \ 'database-add-phrase-around',
        \ 'database-add-phrase-through',
        \ 'database-add-range-element-attribute-index',
        \ 'database-add-range-element-index',
        \ 'database-add-range-field-index',
        \ 'database-add-word-lexicon',
        \ 'database-add-word-query-excluded-element',
        \ 'database-add-word-query-included-element',
        \ 'database-attach-forest',
        \ 'database-copy',
        \ 'database-create',
        \ 'database-daily-backup',
        \ 'database-delete',
        \ 'database-delete-backup',
        \ 'database-delete-element-attribute-word-lexicon',
        \ 'database-delete-element-word-lexicon',
        \ 'database-delete-element-word-query-through',
        \ 'database-delete-field',
        \ 'database-delete-field-excluded-element',
        \ 'database-delete-field-included-element',
        \ 'database-delete-field-word-lexicon',
        \ 'database-delete-foreign-master',
        \ 'database-delete-foreign-replicas',
        \ 'database-delete-fragment-parent',
        \ 'database-delete-fragment-root',
        \ 'database-delete-geospatial-element-attribute-pair-index',
        \ 'database-delete-geospatial-element-child-index',
        \ 'database-delete-geospatial-element-index',
        \ 'database-delete-geospatial-element-pair-index',
        \ 'database-delete-merge-blackout',
        \ 'database-delete-phrase-around',
        \ 'database-delete-phrase-through',
        \ 'database-delete-range-element-attribute-index',
        \ 'database-delete-range-element-index',
        \ 'database-delete-range-field-index',
        \ 'database-delete-word-lexicon',
        \ 'database-delete-word-query-excluded-element',
        \ 'database-delete-word-query-included-element',
        \ 'database-detach-forest',
        \ 'database-element-attribute-word-lexicon',
        \ 'database-element-word-lexicon',
        \ 'database-element-word-query-through',
        \ 'database-excluded-element',
        \ 'database-exists',
        \ 'database-field',
        \ 'database-foreign-master',
        \ 'database-foreign-master-get-cluster-id',
        \ 'database-foreign-master-get-connect-forests-by-name',
        \ 'database-foreign-master-get-database-id',
        \ 'database-foreign-replica',
        \ 'database-foreign-replica-get-cluster-id',
        \ 'database-foreign-replica-get-connect-forests-by-name',
        \ 'database-foreign-replica-get-database-id',
        \ 'database-foreign-replica-get-lag-limit',
        \ 'database-fragment-parent',
        \ 'database-fragment-root',
        \ 'database-geospatial-element-attribute-pair-index',
        \ 'database-geospatial-element-child-index',
        \ 'database-geospatial-element-index',
        \ 'database-geospatial-element-pair-index',
        \ 'database-get-attached-forests',
        \ 'database-get-attribute-value-positions',
        \ 'database-get-backups',
        \ 'database-get-collection-lexicon',
        \ 'database-get-config-for-foreign-master-on-foreign-cluster',
        \ 'database-get-config-for-foreign-replicas-on-foreign-cluster',
        \ 'database-get-directory-creation',
        \ 'database-get-element-attribute-word-lexicons',
        \ 'database-get-element-value-positions',
        \ 'database-get-element-word-lexicons',
        \ 'database-get-element-word-positions',
        \ 'database-get-element-word-query-throughs',
        \ 'database-get-enabled',
        \ 'database-get-expunge-locks',
        \ 'database-get-fast-case-sensitive-searches',
        \ 'database-get-fast-diacritic-sensitive-searches',
        \ 'database-get-fast-element-character-searches',
        \ 'database-get-fast-element-phrase-searches',
        \ 'database-get-fast-element-trailing-wildcard-searches',
        \ 'database-get-fast-element-word-searches',
        \ 'database-get-fast-phrase-searches',
        \ 'database-get-fast-reverse-searches',
        \ 'database-get-field',
        \ 'database-get-field-excluded-elements',
        \ 'database-get-field-fast-case-sensitive-searches',
        \ 'database-get-field-fast-diacritic-sensitive-searches',
        \ 'database-get-field-fast-phrase-searches',
        \ 'database-get-field-include-document-root',
        \ 'database-get-field-included-elements',
        \ 'database-get-field-one-character-searches',
        \ 'database-get-field-stemmed-searches',
        \ 'database-get-field-three-character-searches',
        \ 'database-get-field-three-character-word-positions',
        \ 'database-get-field-trailing-wildcard-searches',
        \ 'database-get-field-trailing-wildcard-word-positions',
        \ 'database-get-field-two-character-searches',
        \ 'database-get-field-value-positions',
        \ 'database-get-field-value-searches',
        \ 'database-get-field-word-lexicons',
        \ 'database-get-field-word-searches',
        \ 'database-get-fields',
        \ 'database-get-foreign-master',
        \ 'database-get-foreign-replicas',
        \ 'database-get-format-compatibility',
        \ 'database-get-fragment-parents',
        \ 'database-get-fragment-roots',
        \ 'database-get-geospatial-element-attribute-pair-indexes',
        \ 'database-get-geospatial-element-child-indexes',
        \ 'database-get-geospatial-element-indexes',
        \ 'database-get-geospatial-element-pair-indexes',
        \ 'database-get-id',
        \ 'database-get-in-memory-limit',
        \ 'database-get-in-memory-list-size',
        \ 'database-get-in-memory-range-index-size',
        \ 'database-get-in-memory-reverse-index-size',
        \ 'database-get-in-memory-tree-size',
        \ 'database-get-index-detection',
        \ 'database-get-inherit-collections',
        \ 'database-get-inherit-permissions',
        \ 'database-get-inherit-quality',
        \ 'database-get-journal-size',
        \ 'database-get-journaling',
        \ 'database-get-language',
        \ 'database-get-large-size-threshold',
        \ 'database-get-locking',
        \ 'database-get-maintain-directory-last-modified',
        \ 'database-get-maintain-last-modified',
        \ 'database-get-merge-blackouts',
        \ 'database-get-merge-max-size',
        \ 'database-get-merge-min-ratio',
        \ 'database-get-merge-min-size',
        \ 'database-get-merge-priority',
        \ 'database-get-merge-timestamp',
        \ 'database-get-name',
        \ 'database-get-one-character-searches',
        \ 'database-get-phrase-arounds',
        \ 'database-get-phrase-throughs',
        \ 'database-get-positions-list-max-size',
        \ 'database-get-preallocate-journals',
        \ 'database-get-preload-mapped-data',
        \ 'database-get-preload-replica-mapped-data',
        \ 'database-get-range-element-attribute-indexes',
        \ 'database-get-range-element-indexes',
        \ 'database-get-range-field-indexes',
        \ 'database-get-range-index-optimize',
        \ 'database-get-reindexer-enable',
        \ 'database-get-reindexer-throttle',
        \ 'database-get-reindexer-timestamp',
        \ 'database-get-schema-database',
        \ 'database-get-security-database',
        \ 'database-get-stemmed-searches',
        \ 'database-get-tf-normalization',
        \ 'database-get-three-character-searches',
        \ 'database-get-three-character-word-positions',
        \ 'database-get-trailing-wildcard-searches',
        \ 'database-get-trailing-wildcard-word-positions',
        \ 'database-get-triggers-database',
        \ 'database-get-two-character-searches',
        \ 'database-get-uri-lexicon',
        \ 'database-get-word-lexicons',
        \ 'database-get-word-positions',
        \ 'database-get-word-query-excluded-elements',
        \ 'database-get-word-query-fast-case-sensitive-searches',
        \ 'database-get-word-query-fast-diacritic-sensitive-searches',
        \ 'database-get-word-query-fast-phrase-searches',
        \ 'database-get-word-query-include-document-root',
        \ 'database-get-word-query-included-elements',
        \ 'database-get-word-query-one-character-searches',
        \ 'database-get-word-query-stemmed-searches',
        \ 'database-get-word-query-three-character-searches',
        \ 'database-get-word-query-three-character-word-positions',
        \ 'database-get-word-query-trailing-wildcard-searches',
        \ 'database-get-word-query-trailing-wildcard-word-positions',
        \ 'database-get-word-query-two-character-searches',
        \ 'database-get-word-query-word-searches',
        \ 'database-get-word-searches',
        \ 'database-hourly-backup',
        \ 'database-included-element',
        \ 'database-minutely-backup',
        \ 'database-monthly-backup',
        \ 'database-one-time-backup',
        \ 'database-one-time-merge-blackout',
        \ 'database-phrase-around',
        \ 'database-phrase-through',
        \ 'database-range-element-attribute-index',
        \ 'database-range-element-index',
        \ 'database-range-field-index',
        \ 'database-recurring-merge-blackout',
        \ 'database-set-attribute-value-positions',
        \ 'database-set-collection-lexicon',
        \ 'database-set-directory-creation',
        \ 'database-set-element-value-positions',
        \ 'database-set-element-word-positions',
        \ 'database-set-enabled',
        \ 'database-set-expunge-locks',
        \ 'database-set-fast-case-sensitive-searches',
        \ 'database-set-fast-diacritic-sensitive-searches',
        \ 'database-set-fast-element-character-searches',
        \ 'database-set-fast-element-phrase-searches',
        \ 'database-set-fast-element-trailing-wildcard-searches',
        \ 'database-set-fast-element-word-searches',
        \ 'database-set-fast-phrase-searches',
        \ 'database-set-fast-reverse-searches',
        \ 'database-set-field-fast-case-sensitive-searches',
        \ 'database-set-field-fast-diacritic-sensitive-searches',
        \ 'database-set-field-fast-phrase-searches',
        \ 'database-set-field-include-document-root',
        \ 'database-set-field-name',
        \ 'database-set-field-one-character-searches',
        \ 'database-set-field-stemmed-searches',
        \ 'database-set-field-three-character-searches',
        \ 'database-set-field-three-character-word-positions',
        \ 'database-set-field-trailing-wildcard-searches',
        \ 'database-set-field-trailing-wildcard-word-positions',
        \ 'database-set-field-two-character-searches',
        \ 'database-set-field-value-positions',
        \ 'database-set-field-value-searches',
        \ 'database-set-field-word-searches',
        \ 'database-set-foreign-master',
        \ 'database-set-foreign-replicas',
        \ 'database-set-format-compatibility',
        \ 'database-set-in-memory-limit',
        \ 'database-set-in-memory-list-size',
        \ 'database-set-in-memory-range-index-size',
        \ 'database-set-in-memory-reverse-index-size',
        \ 'database-set-in-memory-tree-size',
        \ 'database-set-index-detection',
        \ 'database-set-inherit-collections',
        \ 'database-set-inherit-permissions',
        \ 'database-set-inherit-quality',
        \ 'database-set-journal-size',
        \ 'database-set-journaling',
        \ 'database-set-language',
        \ 'database-set-large-size-threshold',
        \ 'database-set-locking',
        \ 'database-set-maintain-directory-last-modified',
        \ 'database-set-maintain-last-modified',
        \ 'database-set-merge-max-size',
        \ 'database-set-merge-min-ratio',
        \ 'database-set-merge-min-size',
        \ 'database-set-merge-priority',
        \ 'database-set-merge-timestamp',
        \ 'database-set-name',
        \ 'database-set-one-character-searches',
        \ 'database-set-positions-list-max-size',
        \ 'database-set-preallocate-journals',
        \ 'database-set-preload-mapped-data',
        \ 'database-set-preload-replica-mapped-data',
        \ 'database-set-range-index-optimize',
        \ 'database-set-reindexer-enable',
        \ 'database-set-reindexer-throttle',
        \ 'database-set-reindexer-timestamp',
        \ 'database-set-schema-database',
        \ 'database-set-security-database',
        \ 'database-set-stemmed-searches',
        \ 'database-set-tf-normalization',
        \ 'database-set-three-character-searches',
        \ 'database-set-three-character-word-positions',
        \ 'database-set-trailing-wildcard-searches',
        \ 'database-set-trailing-wildcard-word-positions',
        \ 'database-set-triggers-database',
        \ 'database-set-two-character-searches',
        \ 'database-set-uri-lexicon',
        \ 'database-set-word-positions',
        \ 'database-set-word-query-fast-case-sensitive-searches',
        \ 'database-set-word-query-fast-diacritic-sensitive-searches',
        \ 'database-set-word-query-fast-phrase-searches',
        \ 'database-set-word-query-include-document-root',
        \ 'database-set-word-query-one-character-searches',
        \ 'database-set-word-query-stemmed-searches',
        \ 'database-set-word-query-three-character-searches',
        \ 'database-set-word-query-three-character-word-positions',
        \ 'database-set-word-query-trailing-wildcard-searches',
        \ 'database-set-word-query-trailing-wildcard-word-positions',
        \ 'database-set-word-query-two-character-searches',
        \ 'database-set-word-query-word-searches',
        \ 'database-set-word-searches',
        \ 'database-weekly-backup',
        \ 'database-word-lexicon',
        \ 'foreign-cluster-create',
        \ 'foreign-cluster-delete',
        \ 'foreign-cluster-get-bootstrap-hosts',
        \ 'foreign-cluster-get-host-timeout',
        \ 'foreign-cluster-get-name',
        \ 'foreign-cluster-get-ssl-certificate',
        \ 'foreign-cluster-get-xdqp-ssl-allow-sslv3',
        \ 'foreign-cluster-get-xdqp-ssl-allow-tls',
        \ 'foreign-cluster-get-xdqp-ssl-ciphers',
        \ 'foreign-cluster-get-xdqp-ssl-enabled',
        \ 'foreign-cluster-get-xdqp-timeout',
        \ 'foreign-cluster-replace',
        \ 'foreign-cluster-set-bootstrap-hosts',
        \ 'foreign-cluster-set-host-timeout',
        \ 'foreign-cluster-set-name',
        \ 'foreign-cluster-set-ssl-certificate',
        \ 'foreign-cluster-set-xdqp-ssl-allow-sslv3',
        \ 'foreign-cluster-set-xdqp-ssl-allow-tls',
        \ 'foreign-cluster-set-xdqp-ssl-ciphers',
        \ 'foreign-cluster-set-xdqp-ssl-enabled',
        \ 'foreign-cluster-set-xdqp-timeout',
        \ 'foreign-host',
        \ 'foreign-host-get-connect-port',
        \ 'foreign-host-get-id',
        \ 'foreign-host-get-name',
        \ 'forest-add-backup',
        \ 'forest-add-failover-host',
        \ 'forest-add-foreign-replicas',
        \ 'forest-add-replica',
        \ 'forest-copy',
        \ 'forest-create',
        \ 'forest-daily-backup',
        \ 'forest-delete',
        \ 'forest-delete-backup',
        \ 'forest-delete-failover-host',
        \ 'forest-delete-foreign-master',
        \ 'forest-delete-foreign-replicas',
        \ 'forest-exists',
        \ 'forest-foreign-master',
        \ 'forest-foreign-master-get-cluster-id',
        \ 'forest-foreign-master-get-database-id',
        \ 'forest-foreign-master-get-forest-id',
        \ 'forest-foreign-replica',
        \ 'forest-foreign-replica-get-cluster-id',
        \ 'forest-foreign-replica-get-database-id',
        \ 'forest-foreign-replica-get-forest-id',
        \ 'forest-get-backups',
        \ 'forest-get-data-directory',
        \ 'forest-get-database',
        \ 'forest-get-enabled',
        \ 'forest-get-failover-enable',
        \ 'forest-get-failover-hosts',
        \ 'forest-get-fast-data-directory',
        \ 'forest-get-foreign-master',
        \ 'forest-get-foreign-replicas',
        \ 'forest-get-host',
        \ 'forest-get-id',
        \ 'forest-get-large-data-directory',
        \ 'forest-get-name',
        \ 'forest-get-replicas',
        \ 'forest-get-updates-allowed',
        \ 'forest-hourly-backup',
        \ 'forest-minutely-backup',
        \ 'forest-monthly-backup',
        \ 'forest-one-time-backup',
        \ 'forest-remove-replica',
        \ 'forest-set-enabled',
        \ 'forest-set-failover-enable',
        \ 'forest-set-foreign-master',
        \ 'forest-set-foreign-replicas',
        \ 'forest-set-host',
        \ 'forest-set-updates-allowed',
        \ 'forest-weekly-backup',
        \ 'get-appserver-ids',
        \ 'get-configuration',
        \ 'get-database-ids',
        \ 'get-forest-ids',
        \ 'get-group-ids',
        \ 'get-host-ids',
        \ 'group-add-namespace',
        \ 'group-add-scheduled-task',
        \ 'group-add-schema',
        \ 'group-add-trace-event',
        \ 'group-copy',
        \ 'group-create',
        \ 'group-daily-scheduled-task',
        \ 'group-delete',
        \ 'group-delete-namespace',
        \ 'group-delete-scheduled-task',
        \ 'group-delete-schema',
        \ 'group-delete-trace-event',
        \ 'group-disable-audit-event-type',
        \ 'group-enable-audit-event-type',
        \ 'group-exists',
        \ 'group-get-appserver-ids',
        \ 'group-get-audit-enabled',
        \ 'group-get-audit-event-type-enabled',
        \ 'group-get-audit-excluded-roles',
        \ 'group-get-audit-excluded-uris',
        \ 'group-get-audit-excluded-users',
        \ 'group-get-audit-included-roles',
        \ 'group-get-audit-included-uris',
        \ 'group-get-audit-included-users',
        \ 'group-get-audit-outcome-restriction',
        \ 'group-get-compressed-tree-cache-partitions',
        \ 'group-get-compressed-tree-cache-size',
        \ 'group-get-compressed-tree-read-size',
        \ 'group-get-expanded-tree-cache-partitions',
        \ 'group-get-expanded-tree-cache-size',
        \ 'group-get-failover-enable',
        \ 'group-get-file-log-level',
        \ 'group-get-host-ids',
        \ 'group-get-host-initial-timeout',
        \ 'group-get-host-timeout',
        \ 'group-get-http-timeout',
        \ 'group-get-http-user-agent',
        \ 'group-get-httpserver-ids',
        \ 'group-get-id',
        \ 'group-get-keep-audit-files',
        \ 'group-get-keep-log-files',
        \ 'group-get-list-cache-partitions',
        \ 'group-get-list-cache-size',
        \ 'group-get-name',
        \ 'group-get-namespaces',
        \ 'group-get-retry-timeout',
        \ 'group-get-rotate-audit-files',
        \ 'group-get-rotate-log-files',
        \ 'group-get-scheduled-tasks',
        \ 'group-get-schemas',
        \ 'group-get-smtp-relay',
        \ 'group-get-smtp-timeout',
        \ 'group-get-system-log-level',
        \ 'group-get-taskserver-id',
        \ 'group-get-trace-events',
        \ 'group-get-trace-events-activated',
        \ 'group-get-webdavserver-ids',
        \ 'group-get-xdbcserver-ids',
        \ 'group-get-xdqp-ssl-allow-sslv3',
        \ 'group-get-xdqp-ssl-allow-tls',
        \ 'group-get-xdqp-ssl-ciphers',
        \ 'group-get-xdqp-ssl-enabled',
        \ 'group-get-xdqp-timeout',
        \ 'group-hourly-scheduled-task',
        \ 'group-minutely-scheduled-task',
        \ 'group-monthly-scheduled-task',
        \ 'group-namespace',
        \ 'group-one-time-scheduled-task',
        \ 'group-schema',
        \ 'group-set-audit-enabled',
        \ 'group-set-audit-outcome-restriction',
        \ 'group-set-audit-role-restriction',
        \ 'group-set-audit-uri-restriction',
        \ 'group-set-audit-user-restriction',
        \ 'group-set-compressed-tree-cache-partitions',
        \ 'group-set-compressed-tree-cache-size',
        \ 'group-set-compressed-tree-read-size',
        \ 'group-set-expanded-tree-cache-partitions',
        \ 'group-set-expanded-tree-cache-size',
        \ 'group-set-failover-enable',
        \ 'group-set-file-log-level',
        \ 'group-set-host-initial-timeout',
        \ 'group-set-host-timeout',
        \ 'group-set-http-timeout',
        \ 'group-set-http-user-agent',
        \ 'group-set-keep-audit-files',
        \ 'group-set-keep-log-files',
        \ 'group-set-list-cache-partitions',
        \ 'group-set-list-cache-size',
        \ 'group-set-name',
        \ 'group-set-retry-timeout',
        \ 'group-set-rotate-audit-files',
        \ 'group-set-rotate-log-files',
        \ 'group-set-smtp-relay',
        \ 'group-set-smtp-timeout',
        \ 'group-set-system-log-level',
        \ 'group-set-trace-events-activated',
        \ 'group-set-xdqp-ssl-allow-sslv3',
        \ 'group-set-xdqp-ssl-allow-tls',
        \ 'group-set-xdqp-ssl-ciphers',
        \ 'group-set-xdqp-ssl-enabled',
        \ 'group-set-xdqp-timeout',
        \ 'group-trace-event',
        \ 'group-weekly-scheduled-task',
        \ 'host-exists',
        \ 'host-get-foreign-port',
        \ 'host-get-group',
        \ 'host-get-id',
        \ 'host-get-name',
        \ 'host-get-port',
        \ 'host-set-foreign-port',
        \ 'host-set-group',
        \ 'host-set-name',
        \ 'host-set-port',
        \ 'http-server-create',
        \ 'mimetype',
        \ 'mimetypes-add',
        \ 'mimetypes-delete',
        \ 'mimetypes-get',
        \ 'restart-hosts',
        \ 'save-configuration',
        \ 'save-configuration-without-restart',
        \ 'taskserver-get-debug-allow',
        \ 'taskserver-get-debug-threads',
        \ 'taskserver-get-default-time-limit',
        \ 'taskserver-get-log-errors',
        \ 'taskserver-get-max-time-limit',
        \ 'taskserver-get-name',
        \ 'taskserver-get-post-commit-trigger-depth',
        \ 'taskserver-get-pre-commit-trigger-depth',
        \ 'taskserver-get-pre-commit-trigger-limit',
        \ 'taskserver-get-profile-allow',
        \ 'taskserver-get-queue-size',
        \ 'taskserver-get-threads',
        \ 'taskserver-set-debug-allow',
        \ 'taskserver-set-debug-threads',
        \ 'taskserver-set-default-time-limit',
        \ 'taskserver-set-log-errors',
        \ 'taskserver-set-max-time-limit',
        \ 'taskserver-set-post-commit-trigger-depth',
        \ 'taskserver-set-pre-commit-trigger-depth',
        \ 'taskserver-set-pre-commit-trigger-limit',
        \ 'taskserver-set-profile-allow',
        \ 'taskserver-set-queue-size',
        \ 'taskserver-set-threads',
        \ 'webdav-server-create',
        \ 'xdbc-server-create']
     "}}}


    " let alertfunctions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/alerting.html
    let alertfunctions = [
        \ 'action-get-description',
        \ 'action-get-module',
        \ 'action-get-module-db',
        \ 'action-get-module-root',
        \ 'action-get-name',
        \ 'action-get-options',
        \ 'action-insert',
        \ 'action-remove',
        \ 'action-set-description',
        \ 'action-set-module',
        \ 'action-set-module-db',
        \ 'action-set-module-root',
        \ 'action-set-name',
        \ 'action-set-options',
        \ 'config-delete',
        \ 'config-get',
        \ 'config-get-cpf-domain-names',
        \ 'config-get-description',
        \ 'config-get-id',
        \ 'config-get-name',
        \ 'config-get-options',
        \ 'config-get-trigger-ids',
        \ 'config-get-uri',
        \ 'config-insert',
        \ 'config-set-cpf-domain-names',
        \ 'config-set-description',
        \ 'config-set-name',
        \ 'config-set-options',
        \ 'config-set-trigger-ids',
        \ 'create-triggers',
        \ 'find-matching-rules',
        \ 'get-actions',
        \ 'get-all-rules',
        \ 'get-my-rules',
        \ 'invoke-matching-actions',
        \ 'make-action',
        \ 'make-config',
        \ 'make-log-action',
        \ 'make-rule',
        \ 'remove-triggers',
        \ 'rule-action-query',
        \ 'rule-get-action',
        \ 'rule-get-description',
        \ 'rule-get-id',
        \ 'rule-get-name',
        \ 'rule-get-options',
        \ 'rule-get-query',
        \ 'rule-get-user-id',
        \ 'rule-id-query',
        \ 'rule-insert',
        \ 'rule-name-query',
        \ 'rule-remove',
        \ 'rule-set-action',
        \ 'rule-set-description',
        \ 'rule-set-name',
        \ 'rule-set-options',
        \ 'rule-set-query',
        \ 'rule-set-user-id',
        \ 'rule-user-id-query',
        \ 'spawn-matching-actions']
        "}}}

    " let cpffunctions = ["{{{
    " 2013-08-12 http://http://docs.marklogic.com/cpf
    let all_cpffunctions = [
        \ 'check-transition',
        \ 'document-get-error',
        \ 'document-get-last-updated',
        \ 'document-get-processing-status',
        \ 'document-get-state',
        \ 'document-set-error',
        \ 'document-set-last-updated',
        \ 'document-set-processing-status',
        \ 'document-set-state',
        \ 'failure',
        \ 'success']
    "}}}

    " http://community.marklogic.com/pubs/5.0/apidocs/Classifier.html
    let cts_classifier_functions = ['classify', 'thresholds', 'train']

    " let cts_query_constructor_functions = [ "{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/cts-query.html
    let cts_query_constructor_functions = [
        \ 'and-not-query',
        \ 'and-query',
        \ 'collection-query',
        \ 'directory-query',
        \ 'document-fragment-query',
        \ 'document-query',
        \ 'element-attribute-pair-geospatial-query',
        \ 'element-attribute-range-query',
        \ 'element-attribute-value-query',
        \ 'element-attribute-word-query',
        \ 'element-child-geospatial-query',
        \ 'element-geospatial-query',
        \ 'element-pair-geospatial-query',
        \ 'element-query',
        \ 'element-range-query',
        \ 'element-value-query',
        \ 'element-word-query',
        \ 'field-range-query',
        \ 'field-value-query',
        \ 'field-word-query',
        \ 'locks-query',
        \ 'near-query',
        \ 'not-query',
        \ 'or-query',
        \ 'properties-query',
        \ 'query',
        \ 'registered-query',
        \ 'reverse-query',
        \ 'similar-query',
        \ 'word-query']
        "}}}

    " let ctsgeospatial_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/GeospatialBuiltins.html
    let ctsgeospatial_functions = [
        \ 'arc-intersection',
        \ 'bearing',
        \ 'bounding-boxes',
        \ 'box',
        \ 'box-east',
        \ 'box-intersects',
        \ 'box-north',
        \ 'box-south',
        \ 'box-west',
        \ 'circle',
        \ 'circle-center',
        \ 'circle-intersects',
        \ 'circle-radius',
        \ 'complex-polygon',
        \ 'complex-polygon-contains',
        \ 'complex-polygon-inner',
        \ 'complex-polygon-intersects',
        \ 'complex-polygon-outer',
        \ 'destination',
        \ 'distance',
        \ 'linestring',
        \ 'linestring-vertices',
        \ 'parse-wkt',
        \ 'point',
        \ 'point-latitude',
        \ 'point-longitude',
        \ 'polygon',
        \ 'polygon-contains',
        \ 'polygon-intersects',
        \ 'polygon-vertices',
        \ 'shortest-distance',
        \ 'to-wkt']
        "}}}

    " let ctsgeospatial_lexicons_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/GeospatialLexicons.html
    let ctsgeospatial_lexicons_functions = [
        \ 'element-attribute-pair-geospatial-boxes',
        \ 'element-attribute-pair-geospatial-value-match',
        \ 'element-attribute-pair-geospatial-values',
        \ 'element-attribute-value-geospatial-co-occurrences',
        \ 'element-child-geospatial-boxes',
        \ 'element-child-geospatial-value-match',
        \ 'element-child-geospatial-values',
        \ 'element-geospatial-boxes',
        \ 'element-geospatial-value-match',
        \ 'element-geospatial-values',
        \ 'element-pair-geospatial-boxes',
        \ 'element-pair-geospatial-value-match',
        \ 'element-pair-geospatial-values',
        \ 'element-value-geospatial-co-occurrences',
        \ 'geospatial-co-occurrences']
     "}}}

    " let cts_lexicon_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/Lexicons.html
    let cts_lexicon_functions = [
        \ 'avg',
        \ 'collection-match',
        \ 'collections',
        \ 'count',
        \ 'element-attribute-value-co-occurrences',
        \ 'element-attribute-value-match',
        \ 'element-attribute-value-ranges',
        \ 'element-attribute-values',
        \ 'element-attribute-word-match',
        \ 'element-attribute-words',
        \ 'element-value-co-occurrences',
        \ 'element-value-match',
        \ 'element-value-ranges',
        \ 'element-values',
        \ 'element-word-match',
        \ 'element-words',
        \ 'field-value-co-occurrences',
        \ 'field-value-match',
        \ 'field-value-ranges',
        \ 'field-values',
        \ 'field-word-match',
        \ 'field-words',
        \ 'frequency',
        \ 'sum',
        \ 'uri-match',
        \ 'uris',
        \ 'word-match',
        \ 'words']
        "}}}

    " let cts_search_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/SearchBuiltins.html
    let cts_search_functions = [
        \ 'confidence',
        \ 'contains',
        \ 'deregister',
        \ 'distinctive-terms',
        \ 'entity-highlight',
        \ 'fitness',
        \ 'highlight',
        \ 'quality',
        \ 'register',
        \ 'remainder',
        \ 'score',
        \ 'search',
        \ 'stem',
        \ 'tokenize',
        \ 'walk']
      "}}}

    " http://community.marklogic.com/pubs/5.0/apidocs/Clusterer.html
    let cts_clusterer_functions = ['cluster']

    let all_ctsfunctions = 
        \ cts_classifier_functions +
        \ cts_query_constructor_functions +
        \ cts_lexicon_functions +
        \ cts_search_functions +
        \ cts_clusterer_functions

    " let search_api_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/SearchAPI.html
    let search_api_functions = [
        \ 'check-options',
        \ 'estimate',
        \ 'get-default-options',
        \ 'parse',
        \ 'remove-constraint',
        \ 'resolve',
        \ 'resolve-nodes', 
        \ 'search', 
        \ 'snippet', 
        \ 'suggest', 
        \ 'unparse']
"}}}

    " let xdmp_admin_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/AdminBuiltins.html
    let xdmp_admin_functions = [
        \ 'database-backup',
        \ 'database-backup-cancel',
        \ 'database-backup-purge',
        \ 'database-backup-status',
        \ 'database-backup-validate',
        \ 'database-restore',
        \ 'database-restore-cancel',
        \ 'database-restore-status',
        \ 'database-restore-validate',
        \ 'filesystem-directory',
        \ 'filesystem-file',
        \ 'filesystem-file-exists',
        \ 'filesystem-file-length',
        \ 'forest-backup',
        \ 'forest-clear',
        \ 'forest-open-replica',
        \ 'forest-restart',
        \ 'forest-restore',
        \ 'forest-rollback',
        \ 'merge-cancel',
        \ 'restart',
        \ 'shutdown',
        \ 'start-journal-archiving',
        \ 'stop-journal-archiving']
    "}}}

    " let xdmp_appserver_functions = ["{{{
    let xdmp_appserver_functions = [
        \ 'add-response-header',
        \ 'get-original-url',
        \ 'get-request-body',
        \ 'get-request-client-address',
        \ 'get-request-client-certificate',
        \ 'get-request-field',
        \ 'get-request-field-content-type',
        \ 'get-request-field-filename',
        \ 'get-request-field-names',
        \ 'get-request-header',
        \ 'get-request-header-names',
        \ 'get-request-method',
        \ 'get-request-path',
        \ 'get-request-port',
        \ 'get-request-protocol',
        \ 'get-request-url',
        \ 'get-request-username',
        \ 'get-response-code',
        \ 'get-response-encoding',
        \ 'get-server-field',
        \ 'get-server-field-names',
        \ 'get-session-field',
        \ 'get-session-field-names',
        \ 'get-url-rewriter-path',
        \ 'login',
        \ 'logout',
        \ 'redirect-response',
        \ 'set-request-time-limit',
        \ 'set-response-code',
        \ 'set-response-content-type',
        \ 'set-response-encoding',
        \ 'set-server-field',
        \ 'set-server-field-privilege',
        \ 'set-session-field',
        \ 'uri-is-file',
        \ 'url-decode',
        \ 'url-encode',
        \ 'x509-certificate-extract']
    "}}}

    " let xdmp_document_conversion_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/Document-Conversion.html
    let xdmp_document_conversion_functions = [
        \ 'document-filter', 
        \ 'excel-convert', 
        \ 'gunzip', 
        \ 'gzip', 
        \ 'pdf-convert', 
        \ 'powerpoint-convert', 
        \ 'tidy', 
        \ 'word-convert',
        \ 'zip-create',
        \ 'zip-get',
        \ 'zip-manifest']
     "}}}

    " let exsl_extension_functions = ["{{{
    " part of http://community.marklogic.com/pubs/5.0/apidocs/Extension.html
    let exsl_extension_functions = [
        \ 'node-set',
        \ 'object-type']
    "}}}

    " let xdmp_extension_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/Extension.html
    let xdmp_extension_functions = [
        \ 'access',
        \ 'add64',
        \ 'and64',
        \ 'apply',
        \ 'architecture',
        \ 'base64-decode',
        \ 'base64-encode',
        \ 'binary-decode',
        \ 'binary-is-external',
        \ 'binary-is-large',
        \ 'binary-is-small',
        \ 'binary-size',
        \ 'castable-as',
        \ 'cluster',
        \ 'cluster-name',
        \ 'collation-canonical-uri',
        \ 'collection-locks',
        \ 'collection-properties',
        \ 'configuration-timestamp',
        \ 'crypt',
        \ 'current-last',
        \ 'current-position',
        \ 'database',
        \ 'database-forests',
        \ 'database-global-nonblocking-timestamp',
        \ 'database-is-replica',
        \ 'database-name',
        \ 'database-nonblocking-timestamp',
        \ 'databases',
        \ 'describe',
        \ 'diacritic-less',
        \ 'directory',
        \ 'directory-locks',
        \ 'directory-properties',
        \ 'document-forest',
        \ 'document-get',
        \ 'document-get-collections',
        \ 'document-get-properties',
        \ 'document-get-quality',
        \ 'document-locks',
        \ 'document-properties',
        \ 'elapsed-time',
        \ 'element-content-type',
        \ 'email',
        \ 'encoding-language-detect',
        \ 'estimate',
        \ 'eval',
        \ 'eval-in',
        \ 'exists',
        \ 'external-binary',
        \ 'external-binary-path',
        \ 'foreign-clusters',
        \ 'forest',
        \ 'forest-databases',
        \ 'forest-host',
        \ 'forest-name',
        \ 'forests',
        \ 'format-number',
        \ 'from-json',
        \ 'function',
        \ 'function-module',
        \ 'function-name',
        \ 'get',
        \ 'get-orphaned-binaries',
        \ 'group',
        \ 'group-hosts',
        \ 'group-name',
        \ 'group-servers',
        \ 'groups',
        \ 'hash32',
        \ 'hash64',
        \ 'hex-to-integer',
        \ 'hmac-md5',
        \ 'hmac-sha1',
        \ 'hmac-sha256',
        \ 'hmac-sha512',
        \ 'host',
        \ 'host-forests',
        \ 'host-name',
        \ 'hosts',
        \ 'http-delete',
        \ 'http-get',
        \ 'http-head',
        \ 'http-options',
        \ 'http-post',
        \ 'http-put',
        \ 'integer-to-hex',
        \ 'integer-to-octal',
        \ 'invoke',
        \ 'invoke-in',
        \ 'key-from-QName',
        \ 'log',
        \ 'log-level',
        \ 'lshift64',
        \ 'md5',
        \ 'modules-database',
        \ 'modules-root',
        \ 'mul64',
        \ 'node-database',
        \ 'node-kind',
        \ 'node-uri',
        \ 'not64',
        \ 'octal-to-integer',
        \ 'or64',
        \ 'parse-dateTime',
        \ 'parse-yymmdd',
        \ 'path',
        \ 'plan',
        \ 'platform',
        \ 'pretty-print',
        \ 'product-edition',
        \ 'QName-from-key',
        \ 'query-meters',
        \ 'query-trace',
        \ 'quote',
        \ 'random',
        \ 'remove-orphaned-binary',
        \ 'request',
        \ 'request-timestamp',
        \ 'rethrow',
        \ 'rshift64',
        \ 'schema-database',
        \ 'security-database',
        \ 'server',
        \ 'server-name',
        \ 'servers',
        \ 'set',
        \ 'sha1',
        \ 'sha256',
        \ 'sha512',
        \ 'sleep',
        \ 'spawn',
        \ 'spawn-in',
        \ 'step64',
        \ 'strftime',
        \ 'subbinary',
        \ 'timestamp-to-wallclock',
        \ 'to-json',
        \ 'trace',
        \ 'triggers-database',
        \ 'unpath',
        \ 'unquote',
        \ 'uri-content-type',
        \ 'uri-format',
        \ 'user-last-login',
        \ 'validate',
        \ 'value',
        \ 'version',
        \ 'wallclock-to-timestamp',
        \ 'with-namespaces',
        \ 'xor64',
        \ 'xquery-version',
        \ 'xslt-eval',
        \ 'xslt-invoke']
    "}}}
    
    " let xdmp_security_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/Security.html
    let xdmp_security_functions = [
        \ 'amp',
        \ 'amp-roles',
        \ 'can-grant-roles',
        \ 'default-collections',
        \ 'default-permissions',
        \ 'document-get-permissions',
        \ 'get-current-roles',
        \ 'get-current-user',
        \ 'get-request-user',
        \ 'has-privilege',
        \ 'permission',
        \ 'privilege',
        \ 'privilege-roles',
        \ 'role',
        \ 'role-roles',
        \ 'security-assert',
        \ 'user',
        \ 'user-roles']
        "}}}
   
    " let xdmp_server_monitoring_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/ServerMonitoring.html
    let xdmp_server_monitoring_functions = [
        \ 'cache-status',
        \ 'foreign-cluster-status',
        \ 'forest-counts',
        \ 'forest-status',
        \ 'host-status',
        \ 'request-cancel',
        \ 'request-status',
        \ 'server-status']
     "}}}

    " let xdmp_update_functions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/UpdateBuiltins.html
    let xdmp_update_functions = [
        \ 'collection-delete',
        \ 'directory-create',
        \ 'directory-delete',
        \ 'document-add-collections',
        \ 'document-add-permissions',
        \ 'document-add-properties',
        \ 'document-assign',
        \ 'document-delete',
        \ 'document-insert',
        \ 'document-load',
        \ 'document-remove-collections',
        \ 'document-remove-permissions',
        \ 'document-remove-properties',
        \ 'document-set-collections',
        \ 'document-set-permissions',
        \ 'document-set-properties',
        \ 'document-set-property',
        \ 'document-set-quality',
        \ 'load',
        \ 'lock-acquire',
        \ 'lock-for-update',
        \ 'lock-release',
        \ 'merge',
        \ 'merging',
        \ 'node-delete',
        \ 'node-insert-after',
        \ 'node-insert-before',
        \ 'node-insert-child',
        \ 'node-replace',
        \ 'save']
    "}}}

    let COMMON_xdmp_functions = [
        \ 'get-request-field', 
        \ 'document-insert',
        \ 'node-replace',
        \ 'node-insert-child',
        \ 'node-delete',
        \ 'redirect-response']

    let all_xdmp_functions = 
        \ COMMON_xdmp_functions +
        \ xdmp_extension_functions +
        \ xdmp_update_functions +
        \ xdmp_security_functions +
        \ xdmp_admin_functions + 
        \ xdmp_appserver_functions + 
        \ xdmp_document_conversion_functions +
        \ xdmp_server_monitoring_functions

    " let fnfunctions = ["{{{
    " http://community.marklogic.com/pubs/5.0/apidocs/W3C.html
    let fnfunctions = [
        \ 'abs',
        \ 'adjust-date-to-timezone',
        \ 'adjust-dateTime-to-timezone',
        \ 'adjust-time-to-timezone',
        \ 'analyze-string',
        \ 'avg',
        \ 'base-uri',
        \ 'boolean',
        \ 'ceiling',
        \ 'codepoint-equal',
        \ 'codepoints-to-string',
        \ 'collection',
        \ 'compare',
        \ 'concat',
        \ 'contains',
        \ 'count',
        \ 'current',
        \ 'current-date',
        \ 'current-dateTime',
        \ 'current-group',
        \ 'current-grouping-key',
        \ 'current-time',
        \ 'data',
        \ 'day-from-date',
        \ 'day-from-dateTime',
        \ 'days-from-duration',
        \ 'deep-equal',
        \ 'default-collation',
        \ 'distinct-nodes',
        \ 'distinct-values',
        \ 'doc',
        \ 'doc-available',
        \ 'document',
        \ 'document-uri',
        \ 'element-available',
        \ 'empty',
        \ 'encode-for-uri',
        \ 'ends-with',
        \ 'error',
        \ 'escape-html-uri',
        \ 'escape-uri',
        \ 'exactly-one',
        \ 'exists',
        \ 'expanded-QName',
        \ 'false',
        \ 'floor',
        \ 'format-date',
        \ 'format-dateTime',
        \ 'format-number',
        \ 'format-time',
        \ 'function-available',
        \ 'generate-id',
        \ 'hours-from-dateTime',
        \ 'hours-from-duration',
        \ 'hours-from-time',
        \ 'id',
        \ 'idref',
        \ 'implicit-timezone',
        \ 'in-scope-prefixes',
        \ 'index-of',
        \ 'insert-before',
        \ 'iri-to-uri',
        \ 'key',
        \ 'lang',
        \ 'last',
        \ 'local-name',
        \ 'local-name-from-QName',
        \ 'lower-case',
        \ 'matches',
        \ 'max',
        \ 'min',
        \ 'minutes-from-dateTime',
        \ 'minutes-from-duration',
        \ 'minutes-from-time',
        \ 'month-from-date',
        \ 'month-from-dateTime',
        \ 'months-from-duration',
        \ 'name',
        \ 'namespace-uri',
        \ 'namespace-uri-for-prefix',
        \ 'namespace-uri-from-QName',
        \ 'nilled',
        \ 'node-kind',
        \ 'node-name',
        \ 'normalize-space',
        \ 'normalize-unicode',
        \ 'not',
        \ 'number',
        \ 'one-or-more',
        \ 'position',
        \ 'prefix-from-QName',
        \ 'QName',
        \ 'regex-group',
        \ 'remove',
        \ 'replace',
        \ 'resolve-QName',
        \ 'resolve-uri',
        \ 'reverse',
        \ 'root',
        \ 'round',
        \ 'round-half-to-even',
        \ 'seconds-from-dateTime',
        \ 'seconds-from-duration',
        \ 'seconds-from-time',
        \ 'starts-with',
        \ 'static-base-uri',
        \ 'string',
        \ 'string-join',
        \ 'string-length',
        \ 'string-pad',
        \ 'string-to-codepoints',
        \ 'subsequence',
        \ 'substring',
        \ 'substring-after',
        \ 'substring-before',
        \ 'subtract-dateTimes-yielding-dayTimeDuration',
        \ 'subtract-dateTimes-yielding-yearMonthDuration',
        \ 'sum',
        \ 'system-property',
        \ 'timezone-from-date',
        \ 'timezone-from-dateTime',
        \ 'timezone-from-time',
        \ 'tokenize',
        \ 'trace',
        \ 'translate',
        \ 'true',
        \ 'type-available',
        \ 'unordered',
        \ 'unparsed-entity-public-id',
        \ 'unparsed-entity-uri',
        \ 'unparsed-text',
        \ 'unparsed-text-available',
        \ 'upper-case',
        \ 'year-from-date',
        \ 'year-from-dateTime',
        \ 'years-from-duration',
        \ 'zero-or-one']
      "}}}

    " let functxFunctions = ["{{{
    " http://www.xqueryfunctions.com/xq/alpha.html
    let functxFunctions = [
        \ 'add-attributes',
        \ 'add-months',
        \ 'add-or-update-attributes',
        \ 'all-whitespace',
        \ 'are-distinct-values',
        \ 'atomic-type',
        \ 'avg-empty-is-zero',
        \ 'between-exclusive',
        \ 'between-inclusive',
        \ 'camel-case-to-words',
        \ 'capitalize-first',
        \ 'change-element-names-deep',
        \ 'change-element-ns-deep',
        \ 'change-element-ns',
        \ 'chars',
        \ 'contains-any-of',
        \ 'contains-case-insensitive',
        \ 'contains-word',
        \ 'copy-attributes',
        \ 'date',
        \ 'dateTime',
        \ 'day-in-year',
        \ 'day-of-week-abbrev-en',
        \ 'day-of-week-name-en',
        \ 'day-of-week',
        \ 'dayTimeDuration',
        \ 'days-in-month',
        \ 'depth-of-node',
        \ 'distinct-attribute-names',
        \ 'distinct-deep',
        \ 'distinct-element-names',
        \ 'distinct-element-paths',
        \ 'distinct-nodes',
        \ 'duration-from-timezone',
        \ 'dynamic-path',
        \ 'escape-for-regex',
        \ 'exclusive-or',
        \ 'first-day-of-month',
        \ 'first-day-of-year',
        \ 'first-node',
        \ 'follows-not-descendant',
        \ 'format-as-title-en',
        \ 'fragment-from-uri',
        \ 'get-matches-and-non-matches',
        \ 'get-matches',
        \ 'has-element-only-content',
        \ 'has-empty-content',
        \ 'has-mixed-content',
        \ 'has-simple-content',
        \ 'id-from-element',
        \ 'id-untyped',
        \ 'if-absent',
        \ 'if-empty',
        \ 'index-of-deep-equal-node',
        \ 'index-of-match-first',
        \ 'index-of-node',
        \ 'index-of-string-first',
        \ 'index-of-string-last',
        \ 'index-of-string',
        \ 'insert-string',
        \ 'is-a-number',
        \ 'is-absolute-uri',
        \ 'is-ancestor',
        \ 'is-descendant',
        \ 'is-leap-year',
        \ 'is-node-among-descendants-deep-equal',
        \ 'is-node-among-descendants',
        \ 'is-node-in-sequence-deep-equal',
        \ 'is-node-in-sequence',
        \ 'is-value-in-sequence',
        \ 'last-day-of-month',
        \ 'last-day-of-year',
        \ 'last-node',
        \ 'leaf-elements',
        \ 'left-trim',
        \ 'line-count',
        \ 'lines',
        \ 'max-depth',
        \ 'max-determine-type',
        \ 'max-line-length',
        \ 'max-node',
        \ 'max-string',
        \ 'min-determine-type',
        \ 'min-node',
        \ 'min-non-empty-string',
        \ 'min-string',
        \ 'mmddyyyy-to-date',
        \ 'month-abbrev-en',
        \ 'month-name-en',
        \ 'name-test',
        \ 'namespaces-in-use',
        \ 'next-day',
        \ 'node-kind',
        \ 'non-distinct-values',
        \ 'number-of-matches',
        \ 'open-ref-document',
        \ 'ordinal-number-en',
        \ 'pad-integer-to-length',
        \ 'pad-string-to-length',
        \ 'path-to-node-with-pos',
        \ 'path-to-node',
        \ 'precedes-not-ancestor',
        \ 'previous-day',
        \ 'remove-attributes-deep',
        \ 'remove-attributes',
        \ 'remove-elements-deep',
        \ 'remove-elements-not-contents',
        \ 'remove-elements',
        \ 'repeat-string',
        \ 'replace-beginning',
        \ 'replace-element-values',
        \ 'replace-first',
        \ 'replace-multi',
        \ 'reverse-string',
        \ 'right-trim',
        \ 'scheme-from-uri',
        \ 'sequence-deep-equal',
        \ 'sequence-node-equal-any-order',
        \ 'sequence-node-equal',
        \ 'sequence-type',
        \ 'siblings-same-name',
        \ 'siblings',
        \ 'sort-as-numeric',
        \ 'sort-case-insensitive',
        \ 'sort-document-order',
        \ 'sort',
        \ 'substring-after-if-contains',
        \ 'substring-after-last-match',
        \ 'substring-after-last',
        \ 'substring-after-match',
        \ 'substring-before-if-contains',
        \ 'substring-before-last-match',
        \ 'substring-before-last',
        \ 'substring-before-match',
        \ 'time',
        \ 'timezone-from-duration',
        \ 'total-days-from-duration',
        \ 'total-hours-from-duration',
        \ 'total-minutes-from-duration',
        \ 'total-months-from-duration',
        \ 'total-seconds-from-duration',
        \ 'total-years-from-duration',
        \ 'trim',
        \ 'update-attributes',
        \ 'value-except',
        \ 'value-intersect',
        \ 'value-union',
        \ 'word-count',
        \ 'words-to-camel-case',
        \ 'wrap-values-in-elements',
        \ 'yearMonthDuration']
    "}}}

    " 8/6/2010  Putting variable types here 

    "  see Walmsley:490  in index!
    "  atomicType chart?   Walmsley:144
    "  generic sequence types?  Walmsley:152
    "
    "    wat about.... 
    "       comment()
    "       processing-instruction()
    "       document-node()
    "
    " let generic_types = ["{{{
    let generic_types = [
        \ 'item()', 
        \ 'node()',
        \ 'text()',
        \ 'empty-sequence()',
        \ 'element()', 
        \ 'document()'
        \ ]
    "}}}

    " these are prefixed with xs:  
    " let atomic_types = ["{{{
    let atomic_types = [
        \ 'xs:string',
        \ 'xs:dateTime',
        \ 'xs:anyAtomicType',
        \ 'xs:anyType',
        \ 'xs:anyURI',
        \ 'xs:base64Binary',
        \ 'xs:boolean',
        \ 'xs:date',
        \ 'xs:dayTimeDuration',
        \ 'xs:decimal',
        \ 'xs:double',
        \ 'xs:duration',
        \ 'xs:float',
        \ 'xs:gDay',
        \ 'xs:gMonth',
        \ 'xs:gMonthDay',
        \ 'xs:gYearMonth',
        \ 'xs:gYear',
        \ 'xs:hexBinary',
        \ 'xs:integer',
        \ 'xs:negativeInteger',
        \ 'xs:nonPositiveInteger',
        \ 'xs:nonNegativeInteger',
        \ 'xs:normalizedString',
        \ 'xs:positiveInteger',
        \ 'xs:time',
        \ 'xs:QName',
        \ 'xs:unsignedByte',
        \ 'xs:unsignedInt',
        \ 'xs:unsignedLong',
        \ 'xs:unsignedShort',
        \ 'xs:yearMonthDuration'
        \ ]
    "}}}

    let all_types = generic_types + atomic_types

    " Derived from using _ctags options to generate tags from MarkLogic6
    " geospatial completion function names {{{
    " let COMMON_geospatial_functions {{{
    let COMMON_geospatial_functions = [
        \ 'geospatial-query',
        \ 'geospatial-query',
        \ 'geospatial-query-from-elements',
        \ 'geospatial-query-from-elements',
        \ 'point',
        \ 'circle',
        \ 'box',
        \ 'polygon'
        \ ]
    " }}}

    let geo_functions = [ ]
    let all_geo_functions =
        \ COMMON_geospatial_functions + geo_functions

    let georss_functions = [ ]
    let all_georss_functions =
        \ COMMON_geospatial_functions + georss_functions

    let gml_functions = [
        \ 'DEFAULT-WEIGHT',
        \ 'interior-polygon'
        \ ]
    let all_gml_functions =
        \ COMMON_geospatial_functions + gml_functions

    let kml_functions = [
        \ 'DEFAULT-WEIGHT',
        \ 'interior-polygon'
        \ ]
    let all_kml_functions =
        \ COMMON_geospatial_functions + kml_functions


    let mcgm_functions = [
        \ 'DEFAULT-WEIGHT'
        \ ]
    let all_mcgm_functions =
        \ COMMON_geospatial_functions + mcgm_functions
    "}}}

    " 8/3/2010  leaving out XInclude stuff intentionally...

    " Added function names from MarkLogic6 above - 10/8/2012
    let geospatial_namespaces       = ["geo", "georss", "gml", "kml", "mcgm"]

    let library_modules_namespaces  = ["admin", "alert", "dls", "entity", "exsl", "functx", "pki", "search", "sec", "spell", "thsr", "trgr", "ooxml"]
    let cpf_function_namespaces     = ["cpf", "css", "dbk", "dom", "cvt", "lnk", "msword", "pdf", "p", "ppt", "xhtml"]
    let builtin_function_namespaces = ["cts", "dbg", "fn", "map", "math", "prof",  "xdmp"]

    " From spec: 'Certain namespace prefixes are predeclared by XQuery and
    " bound to fixed namespace URIs. These namespace prefixes are as follows:'
    let predeclared_namespaces = ['fn', 'xs', 'local', 'xsi', 'xml']

    let ALL_FUNCTION_NAMESPACES = 
        \ library_modules_namespaces +
        \ cpf_function_namespaces +
        \ builtin_function_namespaces +
        \ predeclared_namespaces +
        \ geospatial_namespaces

    "  When completing a namespace, the user will almost 
    "  always want the colon after it too!
    "
    "   --> see javascriptcomplete.vim:583
    "
	call map(ALL_FUNCTION_NAMESPACES, 'v:val.":"')

    let namespace            = a:base
    let function_completions = []
    let final_menu           = []

    if namespace =~ 'xdmp'
      call map(all_xdmp_functions, '"xdmp:" . v:val . "("')
      let function_completions = copy(all_xdmp_functions)
    elseif namespace =~ 'exsl'
      call map(exsl_extension_functions, '"exsl:" . v:val . "("')
      let function_completions = copy(exsl_extension_functions)
    elseif namespace =~ 'cts'
      call map(all_ctsfunctions, '"cts:" . v:val . "("')
      let function_completions = copy(all_ctsfunctions)
    elseif namespace =~ 'cpf'
      call map(all_cpffunctions, '"cpf:" . v:val . "("')
      let function_completions = copy(all_cpffunctions)
    elseif namespace =~ 'functx'
      call map(functxFunctions, '"functx:" . v:val . "("')
      let function_completions = copy(functxFunctions)
    elseif namespace =~ 'fn'
      call map(fnfunctions, '"fn:" . v:val . "("')
      let function_completions = copy(fnfunctions)
    elseif namespace =~ 'search'
      call map(search_api_functions, '"search:" . v:val . "("')
      let function_completions = copy(search_api_functions)
    elseif namespace =~ 'admin'
      call map(admin_api_functions, '"admin:" . v:val . "("')
      let function_completions = copy(admin_api_functions)
    elseif namespace =~ 'alert'
      call map(alertfunctions, '"alert:" . v:val . "("')
      let function_completions = copy(alertfunctions)
    elseif namespace =~ 'georss'
      call map(all_georss_functions, '"georss:" . v:val . "("')
      let function_completions = copy(all_georss_functions)
    elseif namespace =~ 'geo'
      call map(all_geo_functions, '"geo:" . v:val . "("')
      let function_completions = copy(all_geo_functions)
    elseif namespace =~ 'gml'
      call map(all_gml_functions, '"gml:" . v:val . "("')
      let function_completions = copy(all_gml_functions)
    elseif namespace =~ 'kml'
      call map(all_kml_functions, '"kml:" . v:val . "("')
      let function_completions = copy(all_kml_functions)
    elseif namespace =~ 'mcgm'
      call map(all_mcgm_functions, '"mcgm:" . v:val . "("')
      let function_completions = copy(all_mcgm_functions)
    elseif namespace =~ 'xs'
      let function_completions = atomic_types
    endif


    " see Walmsley p. 27 'Categories of Expressions'

    "let keywords = ["{{{
    let keywords = [
        \ "for", 
        \ "let", 
        \ "where", 
        \ "order by", 
        \ "return", 
        \ "some", 
        \ "every", 
        \ "in", 
        \ "satisfies", 
        \ "to", 
        \ "union", 
        \ "intersect", 
        \ "except", 
        \ "instance of", 
        \ "typeswitch", 
        \ "cast as", 
        \ "castable as", 
        \ "treat", 
        \ 'variable',
        \ "validate", 
        \ "div", 
        \ "idiv", 
        \ "mod", 
        \ "xquery version \"1.0-ml\";",
        \ "xquery version \"0.9-ml\";",
        \ "xquery version \"1.0\";",
        \ "xquery version"
        \ ]
    "}}}
    
    "  hmmm above ^ dont have everything 
    
    " let morekeywords = ["{{{
    let morekeywords = [
        \ 'as',
        \ 'declare',
        \ 'declare function',
        \ 'declare variable',
        \ 'declare namespace',
        \ 'declare option',
        \ 'declare default',
        \ 'default',
        \ 'option',
        \ 'collation',
        \ 'element',
        \ 'attribute',
        \ 'function',
        \ 'import',
        \ 'import module',
        \ 'import module namespace',
        \ 'import schema',
        \ 'module',
        \ 'namespace',
        \ 'module namespace',
        \ 'external;',
        \ 'encoding;',
        \ 'ascending',
        \ 'descending',
        \ ]
    "}}}

    " let evenmorekeywords = ["{{{
    let evenmorekeywords = [
        \ 'else',
        \ 'else if',
        \ 'then',
        \ 'if'
        \ ]
    "}}}

    "  let predefined_entity_references = ["{{{
    "  http://www.w3.org/TR/xquery/#dt-predefined-entity-reference
    let predefined_entity_references = [
        \ '&amp;',
        \ '&lt;',
        \ '&gt;',
        \ '&quot;',
        \ '&apos;'
        \ ]
    "}}}


    if(a:base =~ '&$')
        "...the character right before the cursor is an ampersand"
        return predefined_entity_references
    else 
        let res  = []
        let res2 = []
        let values = evenmorekeywords + keywords + morekeywords + function_completions + ALL_FUNCTION_NAMESPACES + generic_types + predefined_entity_references

        for v in values
            if v =~? '^'.a:base
                call add(res, v)
            elseif v =~? a:base
                call add(res2, v)
            endif
        endfor

        let final_menu = res + res2
        return final_menu
    endif

  endif
endfunction 


" vim:sw=4 fdm=marker tw=80
