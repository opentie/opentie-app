module API::Redirect
  def redirect_to(path, opts = {})
    status 302
    header 'X-Location', path
    body opts[:with] unless opts.has_key?(:with)
  end
end
