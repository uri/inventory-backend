object @checkout

attributes :checked_out_at, :checked_in_at

child :reservation do
  attributes :beginning, :ending, :item_id, :user_id
end
