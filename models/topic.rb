class Topic
  attr_accessor :id, :title, :body, :comments, :author, :date


  def self.open_connection
    conn = PG.connect(dbname: "news", user: "postgres", password: "Acad3my1")
  end

  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM mynews ORDER BY news_id"

    results = conn.exec(sql)

    topic = results.map do |data|
      self.hydrate data
    end

    return topic
  end

  def self.hydrate topic_data
    topic = Topic.new

    topic.id = topic_data["news_id"]
    topic.title = topic_data["title"]
    topic.body = topic_data["body"]
    topic.comments = topic_data["comments_count"]
    topic.author = topic_data["author_id"]
    topic.date = topic_data["post_date"]

    return topic
  end

  def self.find id
    conn = self.open_connection

    sql = "SELECT * FROM mynews WHERE news_id = #{id}"

    topic = conn.exec(sql)

    return self.hydrate topic[0]
  end

  def save
    conn = Topic.open_connection

    if !self.id
      sql = "INSERT INTO mynews (title, body, author_id) VALUES ('#{self.title}', '#{self.body}','#{self.author}')"
    else
      sql = "UPDATE mynews SET title='#{self.title}', body='#{self.body}', author_id='#{self.author}' WHERE news_id = #{self.id}"
    end
    conn.exec(sql)
  end

  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM mynews WHERE news_id = #{id}"

    conn.exec(sql)
  end

end
