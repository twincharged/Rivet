# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
joe = User.create!(
  email: "joeritch@email.az.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "joe",
  last_name: "ritch",
  description: "I LOVE CARS. THAT IS ALL."
)

james = User.create!(
  email: "jamesj@email.az.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "james",
  last_name: "june",
  description: "I am a master hookah smoker, busy student, and I like developing front ends in a manner filled with total badassery.",
  : "az.edu"
)

max = User.create!(
  email: "mlow@email.az.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "max",
  last_name: "low"
  )

matty = User.create!(
  email: "mdonald@email.az.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "matty",
  last_name: "donald"
)

johnny = User.create!(
  email: "jhank@email.az.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "johnny",
  last_name: "hank",
  birthday: "2014-02-22"
)

emil = User.create!(
  email: "emilmusket@email.stanford.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "emil",
  last_name: "musket"
)

shaun = User.create!(
  email: "shaunaldrin@email.asu.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "shaun",
  last_name: "aldrin"
)

dogan = User.create!(
  email: "doganstrawberry@email.az.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "dogan",
  last_name: "strawberry",
  gender: "FEMALE"
)

james = User.create!(
  email: "jamessmith@email.asu.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "James",
  last_name: "Smith"
)

bob = User.create!(
  email: "bobjones@email.stanford.edu",
  password: "password",
  password_confirmation: "password",
  first_name: "Bob",
  last_name: "Jones"
)


 Relationship.create!(followed_id: james.id, follower_id: joe.id, accepted: true)

 Relationship.create!(followed_id: james.id, follower_id: matty.id, accepted: true)

 Relationship.create!(followed_id: james.id, follower_id: emil.id, accepted: false)

 Relationship.create!(followed_id: james.id, follower_id: dogan.id, accepted: true)

 Relationship.create!(followed_id: emil.id, follower_id: joe.id, accepted: false)

 Relationship.create!(followed_id: emil.id, follower_id: james.id, accepted: true)

 Relationship.create!(followed_id: emil.id, follower_id: matty.id, accepted: true)

 Relationship.create!(followed_id: emil.id, follower_id: dogan.id, accepted: true)

 Relationship.create!(followed_id: joe.id, follower_id: james.id, accepted: true)

 Relationship.create!(followed_id: joe.id, follower_id: johnny.id, accepted: true)

 Relationship.create!(followed_id: joe.id, follower_id: shaun.id, accepted: false)

 Relationship.create!(followed_id: joe.id, follower_id: dogan.id, accepted: true)

 Relationship.create!(followed_id: max.id, follower_id: matty.id, accepted: false)

 Relationship.create!(followed_id: max.id, follower_id: shaun.id, accepted: true)

 Relationship.create!(followed_id: max.id, follower_id: james.id, accepted: true)

 Relationship.create!(followed_id: matty.id, follower_id: dogan.id, accepted: false)

 Relationship.create!(followed_id: matty.id, follower_id: shaun.id, accepted: true)

 Relationship.create!(followed_id: matty.id, follower_id: joe.id, accepted: true)

 Relationship.create!(followed_id: johnny.id, follower_id: shaun.id, accepted: false)

 Relationship.create!(followed_id: johnny.id, follower_id: joe.id, accepted: true)

 Relationship.create!(followed_id: johnny.id, follower_id: dogan.id, accepted: true)

 Relationship.create!(followed_id: shaun.id, follower_id: joe.id, accepted: true)

 Relationship.create!(followed_id: shaun.id, follower_id: emil.id, accepted: false)

 Relationship.create!(followed_id: shaun.id, follower_id: max.id, accepted: true)

 Relationship.create!(followed_id: dogan.id, follower_id: joe.id, accepted: true)

 Relationship.create!(followed_id: dogan.id, follower_id: johnny.id, accepted: true)

 Relationship.create!(followed_id: dogan.id, follower_id: james.id, accepted: true)

 Relationship.create!(followed_id: dogan.id, follower_id: emil.id, accepted: false)

 Relationship.create!(followed_id: james.id, follower_id: emil.id, accepted: true)

 Relationship.create!(followed_id: james.id, follower_id: james.id, accepted: true)

 Relationship.create!(followed_id: james.id, follower_id: joe.id, accepted: false)

 Relationship.create!(followed_id: bob.id, follower_id: johnny.id, accepted: true)

 Relationship.create!(followed_id: bob.id, follower_id: james.id, accepted: false)

 Relationship.create!(followed_id: bob.id, follower_id: emil.id, accepted: true)

  Post.create!(
  user_id: joe.id,
  body: "IS IT WORKING?!?",
  public: true
)

  Post.create!(
  user_id: james.id,
  body: "Lets go sunnin",
  public: true
)

  Post.create!(
  user_id: emil.id,
  body: "Hydrogen fuel cells are so bullshit.",
  public: true
)

  Post.create!(
  user_id: johnny.id,
  body: "OMG DID YOU GUYS SEE THE NEW BACHELOR EPISODE?? TOTES UNREAL!!",
  public: true
)

  Post.create!(
  user_id: dogan.id,
  body: "Awwww I don't know which girl I should go for.... probably neither :(",
  public: true
)

  Post.create!(
  user_id: joe.id,
  body: "Shut up dogan....",
  public: true
)

  Post.create!(
  user_id: dogan.id,
  body: "SHUT UP JOE",
  public: true
)

  Post.create!(
  user_id: max.id,
  body: "LOKI, bES!!!!",
  public: true
)

  Post.create!(
  user_id: matty.id,
  body: "Only miss the sun when it starts to snow...",
  public: true
)

  Post.create!(
  user_id: shaun.id,
  body: "Yeah! ASU's the best.",
  public: true
)

  Post.create!(
  user_id: max.id,
  body: "Lol, good one shaun.",
  public: true
)


  
  conv1 = Conversation.create


  cu1 = ConversationUser.create(
  user_id: james.id,
  conversation_id: conv1.id
  )

  cu2 = ConversationUser.create(
  user_id: joe.id,
  conversation_id: conv1.id
  )

  mess1 = Message.create(
  user: joe,
  body: 'First message??',
  conversation_id: conv1.id
  )
