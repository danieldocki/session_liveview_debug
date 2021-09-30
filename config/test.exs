import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :session_liveview_debug, SessionLiveviewDebugWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LLnjOT7tV9StcHsQ0Uhg3cFD9Tbq7Xz2PcSDesXq9fQ0g2an0PRN3MMpCcYghhMr",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
