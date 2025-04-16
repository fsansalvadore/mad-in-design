# Stub ActiveStorage service to prevent it from trying to connect to services we don't need
Rails.application.config.to_prepare do
  if Rails.env.development? && defined?(ActiveStorage::Blob) && defined?(ActiveStorage::Service)
    # Create a simple disk service that doesn't throw errors
    disk_service = Class.new(ActiveStorage::Service) do
      attr_reader :root
      
      def initialize(root:)
        @root = root
      end
      
      def upload(key, io, checksum: nil, **)
        # Stub implementation
      end
      
      def download(key, &block)
        # Stub implementation
      end
      
      def delete(key)
        # Stub implementation
      end
      
      def exist?(key)
        false
      end
      
      def url(key, **options)
        "/stub-storage/#{key}"
      end
    end
    
    # Register our disk service
    ActiveStorage::Blob.service = disk_service.new(root: Rails.root.join('tmp/storage'))
  end
end 