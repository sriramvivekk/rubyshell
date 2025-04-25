# Dockerfile

# Use a smaller, more secure Ruby base image
FROM ruby:3.2.2-slim

# Install required Linux packages and Node.js 16
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl \
  gnupg \
  git \
  && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install -y nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.6.8 && bundle _2.6.8_ install

# Copy the rest of the application code
COPY . .

# Expose port 3000 to the outside
EXPOSE 3000

# Start the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
