class Importer
  attr_accessor :host, :os, :list

  def initialize(host, os, list)
    self.host = host
    self.os = os
    self.list = list
  end

  def perform
      Mux.import host, os, list
  end
end
