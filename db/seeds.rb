# WARNING:
# running rake db:seed will delete all existing items data

# Items
# -----

audio_id     = Category.find_by_name('Audio').id
av_misc_id   = Category.find_by_name('AV - Misc').id
computers_id = Category.find_by_name('Computers').id

items = [
  { name: 'Behringer C2 Microphones',
    description: 'This pair of small form factor microphones are excellent for stereo recording and work very well in conjunction with M-Audio Stereo recorder. NOTE: Needs phantom power supply for use with M-Audio recorder. Book as well to ensure available.',
    category_id: audio_id,
    url_id: 'AUD2' },
  { name: 'Matrox Triplehead2go',
    description: 'Triplehead2go is digital version able to run DVI or VGA.',
    category_id: av_misc_id,
    url_id: 'AV8' },
  { name: 'Phantom Power Supply',
    description: 'Phantom power supply runs from direct current or 9V batteries. Needed for use Behringer C2 and C1 microphones. Please book in conjunction.',
    category_id: av_misc_id,
    url_id: 'AV9' },
  { name: 'Mac Mini #1',
    description: '2.26GHz Intel Core 2 Duo 2GB RAM 160GB HD 8x double-layer SuperDrive NVIDIA GeForce 9400M graphics Mac OS X Snow Leopard',
    category_id: computers_id,
    url_id: 'COMP1' }
]

Item.delete_all

items.each do |args|
  Item.create(args.merge({category_id:audio_id}))
end


Reservation.destroy_all

Reservation.create(beginning: Time.now, ending: 2.days.from_now, in_use: true)
