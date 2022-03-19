class Purchase < HistoryPoint
  default_scope { where(history_type: 1) }
end
