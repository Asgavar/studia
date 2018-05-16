package xyz.juraszek.command;

import java.util.Random;
import java.util.concurrent.SynchronousQueue;

public class AutomatedCommandFactoryThread extends Thread {
  private SynchronousQueue<Command> queue;
  private Random rng;

  public AutomatedCommandFactoryThread(SynchronousQueue<Command> queue) {
    this.queue = queue;
    this.rng = new Random();
  }

  @Override
  public void run() {
    while (true) {
      int whichCommandToCreate = this.rng.nextInt(4);
      Command command = null;
      switch (whichCommandToCreate) {
        case 0:
          command = this.createAndSetupCopyFileCommand();
          break;
        case 1:
          command = this.createAndSetupCreateNewRandomFileCommand();
          break;
        case 2:
          command = this.createAndSetupDownloadFileByFtpCommand();
          break;
        case 3:
          command = this.createAndSetupDownloadFileByHttpCommand();
          break;
      }
      try {
        this.queue.add(command);
      } catch (Exception e) {
        continue;
      }
    }
  }

  private Command createAndSetupCopyFileCommand() {
    FileCopier copier = new FileCopier();
    CopyFileCommand command = new CopyFileCommand(copier);
    command.setOption(CommandOption.COPY_FILE_FROM, "plik_jeden.txt");
    command.setOption(CommandOption.COPY_FILE_TO, "plik_dwa.txt");
    return command;
  }

  private Command createAndSetupCreateNewRandomFileCommand() {
    RandomNewFileCreator creator = new RandomNewFileCreator();
    CreateNewRandomFileCommand command = new CreateNewRandomFileCommand(creator);
    command.setOption(CommandOption.NEW_RANDOM_FILENAME, "losowy_plik.txt");
    return command;
  }

  private Command createAndSetupDownloadFileByFtpCommand() {
    FtpDownloader downloader = new FtpDownloader();
    DownloadFileByFtpCommand command = new DownloadFileByFtpCommand(downloader);
    command.setOption(CommandOption.FTP_FILENAME, "plik_ftpowy.txt");
    command.setOption(CommandOption.FTP_SERVER_ADDRESS, "ftp://serwer");
    return command;
  }

  private Command createAndSetupDownloadFileByHttpCommand() {
    HttpDownloader downloader = new HttpDownloader();
    DownloadFileByHttpCommand command = new DownloadFileByHttpCommand(downloader);
    command.setOption(CommandOption.HTTP_FILENAME, "plik_httpowy.txt");
    command.setOption(CommandOption.HTTP_SERVER_ADDRESS, "http://serwer");
    return command;
  }
}
