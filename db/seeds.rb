puts "Seeding database..."

categories = [
  { name: "Painting", description: "Traditional and contemporary paintings in oil, acrylic, watercolor, and mixed media.", slug: "painting" },
  { name: "Sculpture", description: "Three-dimensional artworks in stone, metal, wood, and modern materials.", slug: "sculpture" },
  { name: "Photography", description: "Fine art photography capturing moments, landscapes, and abstract compositions.", slug: "photography" },
  { name: "Digital Art", description: "Art created with digital tools, including generative art and digital illustrations.", slug: "digital-art" },
  { name: "Drawing", description: "Pencil, charcoal, ink, and pastel works on paper.", slug: "drawing" },
  { name: "Print", description: "Lithographs, screen prints, etchings, and limited edition prints.", slug: "print" },
  { name: "Mixed Media", description: "Artworks combining multiple materials and techniques.", slug: "mixed-media" },
  { name: "Textile Art", description: "Fiber arts, tapestries, and fabric-based artworks.", slug: "textile-art" }
]

categories.each do |attrs|
  Category.find_or_create_by!(slug: attrs[:slug]) do |c|
    c.name = attrs[:name]
    c.description = attrs[:description]
  end
end

puts "  Created #{Category.count} categories"

admin = User.find_or_create_by!(email: "admin@artsite.com") do |u|
  u.first_name = "Admin"
  u.last_name = "User"
  u.username = "admin"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :admin
end

puts "  Created admin: admin@artsite.com / password123"

artists_data = [
  { first_name: "Elena", last_name: "Morisot", username: "elena_morisot", email: "elena@artsite.com", bio: "Contemporary abstract painter exploring color theory and emotional landscapes." },
  { first_name: "Marcus", last_name: "Chen", username: "marcus_chen", email: "marcus@artsite.com", bio: "Sculptor and installation artist working with recycled materials." },
  { first_name: "Sofia", last_name: "Nakamura", username: "sofia_nakamura", email: "sofia@artsite.com", bio: "Fine art photographer capturing urban decay and renewal." },
  { first_name: "James", last_name: "Okafor", username: "james_okafor", email: "james@artsite.com", bio: "Digital artist blending traditional African motifs with futuristic themes." },
  { first_name: "Lina", last_name: "Bergstrom", username: "lina_bergstrom", email: "lina@artsite.com", bio: "Mixed media artist creating immersive textile installations." }
]

artists = artists_data.map do |data|
  User.find_or_create_by!(email: data[:email]) do |u|
    u.first_name = data[:first_name]
    u.last_name = data[:last_name]
    u.username = data[:username]
    u.password = "password123"
    u.password_confirmation = "password123"
    u.role = :artist
    u.bio = data[:bio]
  end
end

puts "  Created #{artists.count} artists"

member = User.find_or_create_by!(email: "collector@artsite.com") do |u|
  u.first_name = "Alex"
  u.last_name = "Rivera"
  u.username = "artcollector"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :member
end

puts "  Created collector: collector@artsite.com / password123"

painting = Category.find_by!(slug: "painting")
sculpture = Category.find_by!(slug: "sculpture")
photography = Category.find_by!(slug: "photography")
digital_art = Category.find_by!(slug: "digital-art")
drawing = Category.find_by!(slug: "drawing")
mixed_media = Category.find_by!(slug: "mixed-media")

artworks_data = [
  { title: "Crimson Horizon", description: "An expansive abstract landscape exploring the boundary between earth and sky at dusk. Layers of crimson, gold, and deep indigo create a meditative atmosphere.", artist: artists[0], category: painting, medium: "Oil on Canvas", dimensions: "48 x 72 in", year: 2024, featured: true },
  { title: "Whispers of Light", description: "Delicate interplay of translucent color washes suggesting morning light filtering through leaves.", artist: artists[0], category: painting, medium: "Watercolor on Paper", dimensions: "24 x 30 in", year: 2024, featured: true },
  { title: "Urban Fragment #7", description: "Part of a series examining the overlooked geometry of city infrastructure.", artist: artists[0], category: painting, medium: "Acrylic on Panel", dimensions: "36 x 36 in", year: 2023, featured: false },
  { title: "Emergence", description: "A flowing organic form rising from a rough-hewn base, symbolizing growth from adversity.", artist: artists[1], category: sculpture, medium: "Welded Steel", dimensions: "42 x 18 x 18 in", year: 2024, featured: true },
  { title: "Tide Memory", description: "Cast bronze forms inspired by tidal patterns observed over a year of coastal study.", artist: artists[1], category: sculpture, medium: "Bronze", dimensions: "30 x 24 x 24 in", year: 2023, featured: false },
  { title: "Abandoned Symphony", description: "A decaying concert hall captured in stark monochrome, revealing beauty in deterioration.", artist: artists[2], category: photography, medium: "Archival Pigment Print", dimensions: "40 x 60 in", year: 2024, featured: true },
  { title: "Neon Solitude", description: "A lone figure beneath flickering neon signs in a rain-slicked Tokyo alley.", artist: artists[2], category: photography, medium: "C-Print", dimensions: "30 x 45 in", year: 2024, featured: true },
  { title: "Glass Cathedral", description: "An abandoned greenhouse transformed by time and nature into a cathedral of light.", artist: artists[2], category: photography, medium: "Archival Print", dimensions: "36 x 48 in", year: 2023, featured: false },
  { title: "Afrofuture Genesis", description: "A vibrant digital composition blending Yoruba symbolism with science fiction aesthetics.", artist: artists[3], category: digital_art, medium: "Digital Print", dimensions: "36 x 48 in", year: 2024, featured: true },
  { title: "Neural Garden", description: "An AI-assisted exploration of biological growth patterns rendered in vivid color.", artist: artists[3], category: digital_art, medium: "Digital Print on Aluminum", dimensions: "40 x 40 in", year: 2024, featured: false },
  { title: "Code Poetry #3", description: "Generative art piece derived from algorithmic poetry, printed on hand-made paper.", artist: artists[3], category: digital_art, medium: "Giclée Print", dimensions: "24 x 32 in", year: 2023, featured: false },
  { title: "Woven Histories", description: "A large-scale textile installation incorporating found fabrics from five continents.", artist: artists[4], category: mixed_media, medium: "Mixed Textiles", dimensions: "96 x 120 in", year: 2024, featured: false },
  { title: "Between Worlds", description: "Layered mixed media piece combining photography, embroidery, and natural pigments.", artist: artists[4], category: mixed_media, medium: "Mixed Media on Panel", dimensions: "48 x 36 in", year: 2024, featured: false },
  { title: "Quiet Study", description: "A contemplative charcoal drawing of hands at rest, part of the Stillness series.", artist: artists[0], category: drawing, medium: "Charcoal on Paper", dimensions: "18 x 24 in", year: 2023, featured: false },
  { title: "Fragments of Tomorrow", description: "Abstract ink drawing exploring themes of time, memory, and anticipation.", artist: artists[3], category: drawing, medium: "Ink on Paper", dimensions: "22 x 30 in", year: 2024, featured: false }
]

artworks = artworks_data.map do |data|
  Artwork.find_or_create_by!(title: data[:title]) do |a|
    a.description = data[:description]
    a.artist = data[:artist]
    a.category = data[:category]
    a.medium = data[:medium]
    a.dimensions = data[:dimensions]
    a.year = data[:year]
    a.featured = data[:featured]
    a.status = :published
  end
end

puts "  Created #{artworks.count} artworks"

auction_artworks = artworks.sample(8)
auctions = auction_artworks.each_with_index.map do |artwork, i|
  starting_price = [50, 100, 200, 500, 1000, 250, 150, 75][i] || 100
  starts_at = Time.current - rand(1..5).days
  ends_at = Time.current + rand(1..14).days

  Auction.find_or_create_by!(artwork: artwork) do |a|
    a.seller = artwork.artist
    a.starting_price = starting_price
    a.current_price = starting_price
    a.starts_at = starts_at
    a.ends_at = ends_at
    a.status = :active
  end
end

puts "  Created #{auctions.count} auctions"

bidders = [member, admin] + artists
auctions.each do |auction|
  bid_count = rand(2..6)
  current = auction.starting_price

  bid_count.times do |i|
    bidder = (bidders - [auction.seller]).sample
    increment = auction.bid_increment
    current += increment + rand(0..increment)

    Bid.create!(
      auction: auction,
      bidder: bidder,
      amount: current,
      created_at: auction.starts_at + ((i + 1) * rand(1..12)).hours
    )
  end

  auction.update!(current_price: current)
  auction.update_column(:bids_count, auction.bids.count)
end

puts "  Created #{Bid.count} bids"

auctions.sample(4).each do |auction|
  Watchlist.find_or_create_by!(user: member, auction: auction)
end

puts "  Created #{Watchlist.count} watchlist entries"
puts ""
puts "Seeding complete!"
puts "  Login credentials:"
puts "    Admin:     admin@artsite.com / password123"
puts "    Artist:    elena@artsite.com / password123"
puts "    Collector: collector@artsite.com / password123"
