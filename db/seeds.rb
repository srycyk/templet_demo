
    CATEGORY_TO_QUERY =
      { 'History' => { 'When?' => {reply: 'Now', by: 'me'},
                       'Who?' => {reply: 'Nobody', by: 'you'},
                       'What?' => {reply: 'For', by: 'us'},
                       'Since?' => {reply: 'Before', by: 'them'}
                     },
        'Philosophy' => { 'Why?' => {reply: 'Yes', by: 'the by'},
                          'Which?' => {reply: 'One', by: 'and by'},
                          'If?' => {reply: 'Only', by: 'accident'}
                        },
        'Science' => { 'How?' => {reply: 'Much', by: 'sea'},
                       'Because?' => {reply: 'Of', by: 'horse'}
                     },
        'Geography' => { 'Where?' => {reply: 'There', by: 'anon'} }
      }

    def category(name)
      Category.find_or_create_by name: name
    end

    def question(category, query, **atts)
      category.questions.find_or_create_by atts.merge(query: query)
    end

    def create(category_to_query, *atts)
      category_to_query.each do |category_name, queries|
        queries.each do |(query, answer)|
          question(category(category_name), query, *atts)
            .answers.find_or_create_by(answer)
        end
      end
    end

    ActiveRecord::Base.transaction do
      Category.all.each &:destroy

      create CATEGORY_TO_QUERY
    end

