class ProductsController < ApplicationController
    def index
      # Herhangi bir işlem yapmıyoruz çünkü bir veritabanına bağlı değiliz.
      # Sadece view dosyasını render etmek istiyoruz.
      render "index"
    end
  end
  