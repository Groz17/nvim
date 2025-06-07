-- maybe usable only for read-only files...
return {
  'kristijanhusak/line-notes.nvim',
  opts={mappings=nil},
  cmd = {'LineNotesAdd', 'LineNotesEdit', 'LineNotesPreview', 'LineNotesDelete'},
  keys = {
    { 'gCa', '<cmd>LineNotesAdd<cr>', desc = "Add"},
    { 'gCe', '<cmd>LineNotesEdit<cr>', desc = "Edit"},
    { 'gCp', '<cmd>LineNotesPreview<cr>', desc = "Preview"},
    { 'gCd', '<cmd>LineNotesDelete<cr>', desc = "Delete"},
  },
}
-- Telescope line_notes - All line notes
-- Telescope line_notes_project
