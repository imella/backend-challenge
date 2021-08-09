class Searcher
  attr_reader :member

  def initialize(member)
    @member = member
  end

  # Search by the given term
  # using array_position function to preserve the sorting of values
  # given by the WHERE IN condition
  def search_for(term)
    results = Friendship.find_by_sql(query(term))

    results.map do |result|
      members =  Member.where(id: result.path).order("array_position(array[#{result.path.join(',')}]::bigint[], members.id)")
      members.map(&:full_name).join('->')
    end
  end

  # Using recursive query to create a graph and find friends of friends
  def query(search_term)
    <<-SQL
      with recursive friends_graph (member_id, friend_id, path) as (
        select f.member_id, f.friend_id, array[f.member_id, f.friend_id] as path
        from friendships as f
        where member_id = #{member.id}
        union all
        select graph.member_id, f.friend_id, graph.path || ARRAY[f.friend_id]
        from friendships as f
        join friends_graph as graph
        on f.member_id = graph.friend_id
        and f.friend_id != ALL(graph.path)
      )

      select distinct path from friends_graph
      inner join headings
      on headings.member_id = friends_graph.friend_id
      where headings.name ilike '%#{search_term}%'
    SQL
  end
end
