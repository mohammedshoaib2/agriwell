// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class Symptoms {
  static const Map<String, List<String>> Apple = {
    'Apple Scab': [
      'Small spots on the underside of young leaves or as spots on either surface of older leaves.',
      'The spots (or lesions) are brown or olive-green and have an indefinite margin at first.',
      'The lesions on older leaves are more definite in outline and become velvety-grey to sooty black.',
    ],
    'Black Rot': [
      'Large brown rotten areas can form anywhere on the fruit but are most common on the blossom end.',
      'Brown to black concentric rings can often be seen on larger infections.',
      'The flesh of the apple is brown but remains firm.',
      'Small, black spots can be seen on older fruit infections.'
    ],
    'Cedar Apple Rust': [
      'Disease is most common on apple and crabapple.',
      'Leaf spots are first yellow then turnbright orange-red, often with a bright red border.',
      'Small, raised, black dots form in the center of leaf spots on the upper leaf surface when the leaf spots mature.'
    ],
  };

  static const Map<String, List<String>> BellPepper = {
    'Bacterial  Spot': [
      'Small, yellow-green lesions on young leaves.',
      'Dark, water-soaked lesions on older foliage with yellow circles.',
      'Deformed and twisted leaves.',
      'Water-soaked areas on fruit, becoming rough, brown, scabbed.'
    ],
  };

  static const Map<String, List<String>> Cherry = {
    'Powdery Mildew': [
      'White patches of fungal growth develop on the lower surface of the leaf.',
      'Leaf edges curl upwards, exposing the white, powdery fungal growth.',
      'Purple to reddish blotches may also develop on leaves.',
      'Tiny, round, black fungal structures (cleistothecia) may also be present on the underside of the leaves.',
    ],
  };

  static const Map<String, List<String>> Corn = {
    'Northern Leaf Blight': [
      'canoe-shaped lesions 1 inch to 6 inches long. ',
      'The lesions are initially bordered by gray-green margins. ',
      'They eventually turn tan colored and may contain dark areas of fungal sporulation.',
    ],
    'Common Rust': [
      'Common rust produces rust-colored to dark brown,elongated pustules on both leaf surfaces. ',
      'The pustules contain rust spores (urediniospores) that are cinnamon brown in color. ',
      'Pustules darken as they age.',
    ],
    'Gray Leaf Spot': [
      'Symptoms of gray leaf spot are usually first noticed in the lower leaves. ',
      'Initially, lesions of gray leaf spot begin as a small dot with a yellow halo.',
      'Lesions will elongate over time running parallel to the veins becoming pale brown to gray and rectangular in shape with blunt ends.',
    ],
  };
  static const Map<String, List<String>> Grape = {
    'Black Rot': [
      'Symptoms of black rot first appear as small yellow spots on leaves. ',
      'Enlarged spots (lesions) have a dark brownish-red border with tan to dark brown centers. ',
      'As the infection develops, tiny black dots appear in the lesion, usually in a ring pattern near the border of the lesion.',
    ],
    'Esca​(Black Measles)': [
      'The foliar symptom of Esca is an interveinal "striping". ',
      'The "stripes", which start out as dark red in red cultivars and yellow in white cultivars, dry and become necrotic. ',
      'Foliar symptoms may occur at any time during the growing season, but are most prevalent during July and August.',
    ],
    'Leaf Blight​(Isariopsis Leaf Spot)': [
      'linear reddish-brown streaks that appear and expand upwards on the shoot, darken, crack and develop into cankers. ',
      'Shoots subsequently wilt, droop and dry up and young shoots may develop pale yellowish-green spots on the lowest internodes.',
    ],
  };
  static const Map<String, List<String>> Peach = {
    'Bacterial Spot': [
      'The disease\'s symptoms include fruit spots, leaf spots and twig cankers.',
      'Leaf spots turn from yellow or light green to black or dark brown.',
    ],
  };
  static const Map<String, List<String>> Potato = {
    'Early Blight': [
      'Affected leaves develop circular to angular dark brown lesions 0.12 to 0.16 inch (3–4 mm) in diameter. ',
      'Concentric rings often form in lesions to produce characteristic target-board effect. ',
      'Severely infected leaves turn yellow and drop. Infected tubers show a brown, corky dry rot.',
    ],
    'Late Blight': [
      'The first symptoms of late blight in the field are small, light to dark green, circular to irregular-shaped water-soaked spots.',
      'Small water-soaked spots develop at the tips, margins or any other part of the leaf which enlarge to form irregular dark brown lesions surrounded by a light green halo.',
    ],
  };
  static const Map<String, List<String>> Tomato = {
    'Bacterial Spot': [
      'the initial symptom appears as small, round, water-soaked spots that gradually turn dark-brown or black and are surrounded by yellow halo.',
      'The size of lesions is fairly variable, but rarely develops to more than 1/10 inch in diameter.',
    ],
    'Early Blight': [
      'Initially, small dark spots form on older foliage near the ground.',
      'Larger spots have target-like concentric rings.',
      'Severely infected leaves turn brown and fall off, or dead, dried leaves may cling to the stem.',
      'Seedling stems are infected at or just above the soil line.',
    ],
    'Late Blight': [
      'Leaf symptoms of late blight first appear as small, water-soaked areas that rapidly enlarge to form purple-brown, oily-appearing blotches. ',
      'On the lower side of leaves, rings of grayish white mycelium and spore-forming structures may appear around the blotches.',
    ],
    'Leaf Mold': [
      'The oldest leaves are infected first.',
      'Pale greenish-yellow spots, usually less than 1/4 inch,  with no definite margins, form on the upper sides of leaves.',
    ],
    'Mosaic Virus': [
      'abnormally shaped fruit ',
      'fruit lesions',
      'reduced fruit size',
      'distorted growing points ',
      'abnormal color (often yellowing)',
      'patterns on leaves, distorted stems ',
      'distortion and dwarfing of the plant as a whole.',
    ],
    'Septoria Leaf Spot': [
      'The first symptoms appear as small, water-soaked, circular spots 1/16 to 1/8" in diameter on the undersides of older leaves. ',
      'The centers of these spots then turn gray to tan and have a dark-brown margin. ',
      'The spots are distinctively circular and are often quite numerous.',
    ],
    'Target Spot': [
      'The disease starts as small circular to oval dark brown to black spots on leaves. ',
      'These spots enlarge, becoming oval to angular, and are normally confined within the main veins of the leaflets.',
    ],
    'Two-spotted Spider-mite': [
      'Adult TSSM feed by sucking chlorophyll out of the leaves, creating blotchy pale to reddish-brown spots. ',
      'Feeding injury often gives the top leaf surfaces a mottled or speckled, dull appearance. ',
      'Leaves then turn yellow and drop. Large populations produce visible webbing that can completely cover the leaves.',
    ],
    'Yellow Leaf Curl Virus': [
      'Plants are stunted or dwarfed.',
      'New growth only produced after infection is reduced in size.',
      'Leaflets are rolled upwards and inwards.',
      'Leaves are often bent downwards, stiff, thicker than normal, have a leathery texture, show interveinal chlorosis and are wrinkled.',
      'Young leaves are slightly chlorotic (yellowish).',
    ],
  };
  static const Map<String, List<String>> Rice = {
    'Brown Spot': [
      'Infected seedlings have small, circular, yellow brown or brown lesions that may girdle the coleoptile and distort primary and secondary leaves. ',
      'Starting at tillering stage, lesions can be observed on the leaves. ',
      'They are initially small, circular, and dark brown to purple-brown.',
    ],
    'Hispa': [
      'The mining of the grubs will be clearly seen on the leaves.',
      'Scraping of the upper surface of the leaf blade leaving only ',
      'the lower epidermis as white streaks parallel to the midrib.',
      'Tunneling of larvae through leaf tissue causes irregular translucent white patches that are parallel to the leaf veins.',
    ],
    'Leaf Blast': [
      'Blast symptoms appear on leaves as elliptical spots with light-colored centers and reddish edges. ',
      'The most serious damage from rice blast occurs when the disease attacks the nodes just below the head, often causing the stem to break.',
    ],
  };
}
