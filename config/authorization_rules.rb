authorization do
  role :access do
    has_omnipotence
  end
  role :guest do
    has_permission_on :messages, :to => [:open, :show]
    has_permission_on :message_receipts, :to => :show
  end
end
