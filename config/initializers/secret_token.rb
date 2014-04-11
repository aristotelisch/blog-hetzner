# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Blog::Application.config.secret_key_base = ENV["SECRET_TOKEN"] || "ab0d4a4ce6a0e08fa505144571d44adfd257a1feaba893d302066a2ec4d442c3da61f0072fb30d3aa61479da5fa41b17d3c6a4703d4fff70e78dc95536919b74"
