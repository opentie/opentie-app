# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'Api test for project_controller: ' do
    before do
      @account = Account.first
      login_param = {
        email: @account.email,
        password: 'password'
      }
      post '/api/v1/login', login_param

      @project = Project.first
      @delegate = @project.delegates.find_by(priority: 0)
      @request_ = @delegate.requests.first
      @request_schema = @request_.request_schema
    end

    # show
    it 'GET /api/v1/projects/:id' do
      get "/api/v1/projects/#{@project.id}"

      json = JSON.parse(response.body)
      project = Project.find_by(id: json['project']['id'])

      expect(project).not_to eq(nil)
      expect(json['project']['id']).to eq(@project.id)
      expect(json['following_member']).to eq(2)

      expect(response.status).to eq(200)

      get "/api/v1/projects/hogehogehoge123123"
      expect(response.status).to eq(404)
    end

    # new
    it 'GET /api/v1/projects/new' do
      get "/api/v1/projects/new"

      json = JSON.parse(response.body)

      expect(json['project_schema']).not_to eq(nil)
      expect(response.status).to eq(200)
    end

    # create
    it 'POST /api/v1/projects' do
      params = {
        name: "test_project_name",
        payload: {
          confirm_requirement: 'yes',
          project_member: 'yes',
          project_type: 'normal_indoor',
          attend_geisai: 'yes',
          name: 'ほげ',
          project_name_kana: 'ほげ',
          project_organizer_name: 'ソレイユファンクラブ',
          project_organizer_name_kana: 'それいゆふぁんくらぶ',
          project_attendee_male: '1',
          project_attendee_female: '1',
          project_attendee_guest: '3',
          project_detail: 'ほげほげ',
          project_information: 'ほげほげ',
          attend_eve: 'yes',
          attend_first: 'yes',
          attend_second: 'yes',
          be_cook: 'yes',
          money_transfer: 'no',
          goods_payment: 'no',
          project_notice: '',
          large_power: 'no',
          charcoal_fire: 'no',
          megavolume: 'no',
          electric_power: '1000'
        }
      }
      expect {
        post "/api/v1/projects/", params
      }.to change(Project, :count).by(1), change(Delegate, :count).by(1)
      expect(response.status).to eq(201)
    end

    # edit
    it 'GET /api/v1/projects/:id/edit' do
      get "/api/v1/projects/#{@project.id}/edit"

      json = JSON.parse(response.body)

      expect(json['project_schema']).not_to eq(nil)
      expect(json['project']['id']).to eq(@project.id)
      expect(response.status).to eq(200)
    end

    # update
    it 'PUT /api/v1/projects/:id' do
      attribute_params = {
        payload: {
          "changes" => "chenged",
        }.merge(@project.payload)
      }

      expect {
        put "/api/v1/projects/#{@project.id}", attribute_params
      }.to change(ProjectHistory, :count).by(1)

      @project.reload
      json = JSON.parse(response.body)

      expect(@project.payload).to eq(attribute_params[:payload])
      expect(response.status).to eq(200)
    end


    # new
    it 'GET /api/v1/projects/:id/invitations/new' do
      get "/api/v1/projects/#{@project.id}/invitations/new"
      expect(response.status).to eq(200)
    end

    # create
    it 'POST /api/v1/projects/:id/invitations' do
      params = {
        email: "hoge@example.com"
      }
=begin
      #fix me
      expect {
        post "/api/v1/projects/#{@project.id}/invitations", params
      }.to change(Invitation, :count).by(1), change { ActionMailer::Base.deliveries.count }.by(1)
=end
      post "/api/v1/projects/#{@project.id}/invitations", params

      expect(response.status).to eq(403)
    end

    # new
    it 'DELETE /api/v1/projects/:id/invitations/:id' do
      invitation = @project.invitations.first

      expect {
        delete "/api/v1/projects/#{@project.id}/invitations/#{invitation.id}"
      }.to change(Invitation, :count).by(-1)

      expect(response.status).to eq(200)
    end



    # index
    it 'GET /api/v1/projects/:id/requests/:id/request_schemata/' do
      get "/api/v1/projects/#{@project.id}/request_schemata/"

      json = JSON.parse(response.body)

      json['request_schemata'].each do |schema|
        s = RequestSchema.find_by(id: schema['id'])
        expect(s).not_to eq(nil)
      end

      expect(json['request_schemata'].count).to eq(RequestSchema.all.count)
      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/projects/:id/requests/:id/request_schemata/:id' do
      get "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}"

      json = JSON.parse(response.body)
      schema = RequestSchema.find_by(id: json['request_schema']['id'])

      expect(schema).not_to eq(nil)
      expect(json['request_schema']['id']).to eq(@request_schema.id)

      expect(response.status).to eq(200)

      get "/api/v1/projects/#{@project.id}/request_schemata/hogehogehoge123123"
      expect(response.status).to eq(404)
    end



    # show
    it 'GET /api/v1/projects/:id/request_schemata/:id/request' do
      pending "いつかてすとでーたつくる"
      get "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request"

      json = JSON.parse(response.body)
      request = Request.find_by(id: json['request']['id'])

      expect(request).not_to eq(nil)

      expect(response.status).to eq(200)
    end

    # edit
    it 'GET /api/v1/projects/:id/request_schemata/:id/request/edit' do
      pending "いつかてすとでーたつくる"
      get "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request/edit"

      json = JSON.parse(response.body)
      request = Request.find_by(id: json['request']['id'])

      expect(request).not_to eq(nil)
      expect(json['request_schema']['id']).to eq(@request_schema.id)

      expect(response.status).to eq(200)
    end

    # update
    it 'PUT /api/v1/projects/:id/request_schemata/:id/request' do
      pending "いつかてすとでーたつくる"
      request = Request.without_soft_destroyed.joins(:delegate)
        .where("delegates.project_id = ?", @project.id)
        .where(request_schema_id: @request_schema.id)
        .first.destroy

      update_params = {
        status: 0,
        payload:{
           name:  "upper5string"
        }
      }

      put "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request", update_params

      json = JSON.parse(response.body)
      expect(json['request']['status'].to_i).to eq(update_params[:status])
      expect(json['request']['payload'].deep_symbolize_keys).to eq(update_params[:payload])

      expect(response.status).to eq(200)
    end

    # update with deadline
    it 'PUT /api/v1/projects/:id/request_schemata/:id/request' do
      pending "いつかてすとでーたつくる"
      request = Request.without_soft_destroyed.joins(:delegate)
        .where("delegates.project_id = ?", @project.id)
        .where(request_schema_id: @request_schema.id)
        .first.destroy

      update_params = {
        status: 0,
        payload:{
           name:  "upper5string"
        }
      }

      @request_schema.update(deadline_at: Time.zone.now)
      put "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request", update_params

      json = JSON.parse(response.body)
      expect(json['deadline']).to eq(true)

      expect(response.status).to eq(200)
    end

  end
end
