class User < ApplicationRecord
  devise :saml_authenticatable
end
