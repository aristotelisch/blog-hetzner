Blog::Application.config.session_store :redis_session_store, {
  key: "_blog_redis_session",
  redis: {
    db: 2,
    expire_after: 120.minutes,
    key_prefix: 'blog:session:',
    serializer: :hybrid,
    host: "localhost",
    port: 6379
  }
}
    
