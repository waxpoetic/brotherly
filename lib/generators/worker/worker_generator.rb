class WorkerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_worker
    template 'worker.rb.erb', "app/workers/#{file_name}_worker.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/workers/#{file_name}_worker.rb"
  end

  def generate_job
    generate :job, "#{file_name}_job"
  end

  def edit_job
    gsub_file "app/jobs/#{file_name}_job.rb", "# Do something later", "#{class_name}Worker.perform(model)"
    gsub_file "app/jobs/#{file_name}_job.rb", "def perform(*args)", "def perform(model)"
  end
end
