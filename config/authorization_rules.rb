authorization do
  role :access do
    has_omnipotence
  end
  role :guest do
    has_permission_on :messages, :to => [:open, :show]
  end
end