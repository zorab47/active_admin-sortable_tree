# no regular words or you'll be exposed to dictionary attacks.

token = '9bf407e3407d9e3ae5a7739f8927f80a04b7f376dc1e23de9ae783f03ff0f53df35aa9d1f72e3d0fb1096d29b53f84b1c49b6f4165c66f16bfadf9f1d3b518ad'
if ENV['RAILS_VERSION'] == "3.2"
  Dummy::Application.config.secret_token = token
else
  Dummy::Application.config.secret_key_base = token
end
