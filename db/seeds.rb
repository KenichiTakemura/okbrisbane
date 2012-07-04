# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
# User


Job.delete_all
TopFeedList.delete_all


#2010.upto(2020) do |x| 
#  jobs = Job.create([
#    {category: Job::SEEK, locale: 'ko', user_id: u.id, subject: '#{x}년 브리즈번 한글학교 교사모집합니다. ', description: '안녕하세요\n\ncarindale 부근지역 저녁에 은행청소 하실분 모십니다.\n\n일은 key job 입니다 저랑 우선은 둘이 3시간정도 합니다 나중에는 혼자서 하셔두 되구요.\n\n은행청소 라 쉬운일입니다,\n\njinyoungkkim@gmail.com 으로 레주메 보내주세요^^\n\n학생분도 환영입니다.'},
#  ])
#end
